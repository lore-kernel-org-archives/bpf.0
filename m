Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3BD3655FA;
	Fri,  5 Jun 2026 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692631; cv=none; b=TSbK6iLtlXothGAOwbDLRxuDMTRfd7lyE8L6BwK5HTmZ1XKsSTMoS/tGwdTOhs90brM9yIVyMid32g7Vcc5E1ftcwYvE2USFy6Jev4C0aIDIGL9whAnXQxXw5by8AkRlTO1na3YCk0btEwt3EDVEjdl9aLhc7G4nViOjRWkwBrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692631; c=relaxed/simple;
	bh=dneQpZJPLHfP6JKnpr7kV/Wk7lIOx9P9coYbAN6/+d4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=klyqbsns/KC1ZCZBbwLzwlRXUJPqzHPrt7E4rvVl80zP6T6ku22KqSV2b5+Nb5OnUS+Xrm9oDX9Zken7igsmlcrLM9ud4+byIfgVPqfhRdBxFTTe2sXb1mHZ7k1Az0SJ7ADaka7CpCXGV6z+sfMByKSQ+TsmWzLfVsXtSsuZpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGoiwSQ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGoiwSQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C30F1F00893;
	Fri,  5 Jun 2026 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780692630;
	bh=jrCk6P19v6NkCvWn/IburagsHY6Nf8CVVq24ih2ZYIQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IGoiwSQ9ZZpYJnOdZLm0cNawP2A7skPqQtarEzo1u9ZVNkjI4mhBFz+9FSTHv7km3
	 xKHe00RA2ut5NgPYoCDX0Nq1lYv2DKd6UvDfWdEukT9E4T6fp81L4Q1KRbHD9YGlWt
	 +UUSNAXiwSYvSXKjNTpjR22x+m5H0Gq98VmdDnUNyBhorgkd/CyyMhWP6rJLFCyUCf
	 Lb4YNM2cnzlEQva1Q2GY465cF3Oi/N3D1kHLvrL0hTMujfQVe2dJlLHAKXmW03ZduK
	 Q5Y1aSofgIQidEKdDBh/znPz93jH0EMi/roO4Cs2B4sEvj7BntdzS9oVlhutuTLXcH
	 6gQeEk8NIwRAQ==
Content-Type: multipart/mixed; boundary="===============5870699331573661861=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d75a13a8ff29d61faea4d180b139cc1f73bc38375cedc50544273531005dff4c@mail.kernel.org>
In-Reply-To: <20260605202056.1780352-4-ameryhung@gmail.com>
References: <20260605202056.1780352-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 20:50:30 +0000 (UTC)

--===============5870699331573661861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 5945956a7573..06d9ae24f006 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
>  			return false;
>  		switch (old->refs[i].type) {
>  		case REF_TYPE_PTR:
> +			if (!check_ids(old->refs[i].parent_id, cur->refs[i].parent_id, idmap))
> +				return false;
> +			break;

Feeding parent_id through check_ids() here was raised during review (by
the bpf-ci and Sashiko bots and by Eduard Zingerman on v1) as something
that makes BPF_ID_MAP_SIZE exhaustion more reachable, which would hit the
WARN_ON_ONCE(1) in check_ids() and become a DoS under panic_on_warn.

The agreed resolution in that discussion was to drop the WARN_ON_ONCE(1)
in check_ids(), since not all ids correspond to register or stack slots
anymore:

  https://lore.kernel.org/bpf/6d86c2fae9be63eb110ebd5b3fc19bc4cf1de2dc.camel@gmail.com/

  "I agree that it should be fine to just return false from check_ids()
   if there is no space in the idmap. However, since not all ids
   correspond to register/stack slots anymore, I think that
   WARN_ON_ONCE(1) should be removed."

The reply indicated that removal lands in patch 4 of the series. In this
branch only 3 patches are present, and check_ids() still contains the
WARN_ON_ONCE(1):

kernel/bpf/states.c:check_ids() {
	...
	/* We ran out of idmap slots, which should be impossible */
	WARN_ON_ONCE(1);
	return false;
}

Should the WARN_ON_ONCE(1) removal be applied together with this change,
so the parent_id comparison is not added before its dependent fix is in
place?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27038754519
--===============5870699331573661861==--
