Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE061A9FB7
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788595344; cv=none; b=H7rz77gcNJTewCSAzijCnrA5GdO6YtqiZjuhPe6Hq0DUx2LYkAo68m5+D8NQ/GTYTBSWCIuEEwsX6+yZRzGpJzKXkbxMomD9gmtlM83AR6Nta1CfMHuSk7Rfr6nVhmOf/IeVKYBokkQa9/r6/nVqkNu3CeFlPaiFNvrYsM9BIKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788595344; c=relaxed/simple;
	bh=Wm6n5GpvM5EsaT0miPDlVkQqg5p5giGg+3W6GBrKb5Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OAxFaIREjPCboeNyvMus9gn9a4iyvIcXnQ/91Rfl199cJm7j+ylX+SWf2uTaB5Q1d2tvf8hytUMEZ+TPpvyZLZYdQEfad0hs5NFykdqxgAjgZY6dersIsTRv0X46yLoIHyZYCZ3BGNvARToxifCiNEBJN/E3YSlOy3ymVIBA370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKuxKFX3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKuxKFX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E8B1F00A3E;
	Sat,  5 Sep 2026 08:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788595343;
	bh=aaZZmvN7gE0prOZn5AUysXNFC0rNcPeWDXI/U4NT+cM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TKuxKFX3/uMQQPuThIDppjd1YnEHud2Jf+vOLsgXZ6+thR3NWvwSzbB8wKxGY1fkR
	 LNO+usLSm3lrjb+mDDDXJPiqjXfJfSsPCgVY4qA4v1GOcSQ6y1Zllp7gHqO0yhOqsb
	 +ve+hKqIp2mT/lUWKmpTdyePaAdrN+0MryMlwJAN8sdau9+BodO6z6TFZLDPeUeEfv
	 Y05QYf3v/fYphwU0+UWbv75qFR34rqRUQDy1crODzKPAndLBYDaru9i7r148KGwP9T
	 0KkH21DAwBHq2K1+NhPTbepI2DH+P4vbiwKnCo9cu4B805T2iVRvAk8CeNNG9wOmXQ
	 J4a2CVeeXaHFQ==
Content-Type: multipart/mixed; boundary="===============7060884085303850844=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eb265c8cf370382dc37f90e4a1210cf223b543af2cb14a7005c8695b9ae0621d@mail.kernel.org>
In-Reply-To: <20260905070003.3193366-4-memxor@gmail.com>
References: <20260905070003.3193366-4-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 3/8] bpf: Preserve packet pointer class displacement in regsafe()
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 08:02:22 +0000 (UTC)

--===============7060884085303850844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 36b65797877d..5cf92ce18520 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -854,6 +854,8 @@ struct backtrack_state {
>  struct bpf_id_pair {
>  	u32 old;
>  	u32 cur;
> +	s32 pkt_ptr_delta;
> +	bool pkt_ptr_delta_set;
>  };
>
>  struct bpf_idmap {
> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 66fb11b6c6a7..2f8f3fe164b0 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -339,6 +339,7 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>  	if (idmap->cnt < BPF_ID_MAP_SIZE) {
>  		map[idmap->cnt].old = old_id;
>  		map[idmap->cnt].cur = cur_id;
> +		map[idmap->cnt].pkt_ptr_delta_set = false;
>  		idmap->cnt++;
>  		return true;
>  	}
> @@ -352,6 +353,43 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>  	return false;
>  }
>
> +static bool check_pkt_ptr_ids(const struct bpf_reg_state *old,
> +			      const struct bpf_reg_state *cur,
> +			      struct bpf_idmap *idmap)
> +{
> +	struct bpf_id_pair *map = idmap->map;
> +	s64 delta;
> +	unsigned int i;
> +
> +	if (!check_ids(old->id, cur->id, idmap))
> +		return false;
> +	if (!old->id)
> +		return true;
> +
> +	/*
> +	 * Packet range is shared by all pointers with the same ID. Preserve
> +	 * their relative displacement, while allowing the whole class to move.
> +	 * Packet pointer offsets are bounded by BPF_MAX_VAR_OFF, so the delta
> +	 * between two valid offsets fits in s32.
> +	 */
> +	delta = (s64)(cur->r64.base - old->r64.base);
> +	if (delta < S32_MIN || delta > S32_MAX)
> +		return false;
> +
> +	for (i = 0; i < idmap->cnt; i++) {
> +		if (map[i].old != old->id)
> +			continue;
> +		if (!map[i].pkt_ptr_delta_set) {
> +			map[i].pkt_ptr_delta = delta;
> +			map[i].pkt_ptr_delta_set = true;
> +			return true;
> +		}
> +		return map[i].pkt_ptr_delta == delta;
> +	}
> +
> +	return false;
> +}

This isn't a bug, but since check_ids() at the top has already located
(or just inserted) the entry for old->id, would it be worth having it
hand the slot back so check_pkt_ptr_ids() does not repeat the scan?
That would also let the unreachable return false after the loop go away.

> +
>  /*
>   * Compare scalar register IDs for state equivalence.
>   *

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33952325041
--===============7060884085303850844==--
