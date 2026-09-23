Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24521A459
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142003; cv=none; b=CBYhJEyKUZnNQmB13ONbMHHf7sXAIJM3QoQOhkPB3fY+1X6WaRNQTFlylfud+En5ajC6bl3H6lfDKiD0S8Vg3tlggZshonixJ8vZyEcMGJgs2PdwpZC+Ii5MT5V0ciKgIsbkeRzXr4b9gfOtT/hGTNGHdIRfXixUT6D60g86VhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142003; c=relaxed/simple;
	bh=m+9wQnGzGi8FqT6Zl4FsSChA8NszKxikB3karmX7Ypw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dBFxwYxABjA0oQtTmHhOXj19deC7k47AnxTroDwQWsDtoR49u2GbnVCKZNidhQTp2RHq2lotc36IYVKMKl1VxdNoPIMFabJHqoBcFqG9GHfQq82KXM9nhhVqZ3BEHWC7lFr68rfNu/6J3pR8he5H0TbhM9Mrs/lZ+YJaueKgvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQ/zWfRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQ/zWfRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB90B1F000FF;
	Wed, 23 Sep 2026 05:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790142002;
	bh=Q2SN4nzB6iTIj+iyYAW3q8zdtZxSy+C9UEbKHaMSrac=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aQ/zWfRlBbMZsQ9LwpqPfT+5QKTjCdwxp39fcrMTNDeASgFAO3nmNCvCwHZdEBM0P
	 5KpL3V3pjywotF/gFNAvR8L3oDbEmmlTUM9NOADv3NQG821XLuH3SBVOAXW+Fef3Ps
	 ocnNOtb7djLH7DIl/R9DmZ2edI3PYXQHuOpd+ia8Du0AmpJolYv5ldeUEheoL8zyfc
	 m4sgiwFRqe0pB5wChnl1kr9bAu19c6FWMXUSWOVolVc8To0KL4psDfyyab6jOWeLYM
	 jiRAZRzCU4hNcOmvzT+GQD5eZesgazdCNaCqYM0dQwpVA3AcnNJaFOb2Z5OQ//c7SC
	 YRyFLuOjTjz6g==
Content-Type: multipart/mixed; boundary="===============7930006386070302406=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5bc4c0806e661fc5e4936a0721e0a769b011c149093b245583b9f478209a37f1@mail.kernel.org>
In-Reply-To: <20260923045851.2415163-1-yonghong.song@linux.dev>
References: <20260923045851.2415163-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 01/21] bpf: Pack bpf_insn_aux_data flags into bit fields
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 05:40:00 +0000 (UTC)

--===============7930006386070302406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Pack bpf_insn_aux_data flags into bit fields
>
> struct bpf_insn_aux_data spreads its flags over three places: seven bools a
> byte each, a u8 carrying three bit fields, and a u32 group with 25 of its
> 32 bits spare. Put them all in one u64 word, alu_state with them, and move
> orig_idx below it. The structure goes from 144 bytes to 128 with no holes,
> and 34 bits are left for later flags.

Is the old size correct?  The pre-patch struct appears to be 136 bytes on
x86-64, not 144, which would make the savings 8 bytes rather than 16.

Looking at the layout starting at offset 60 (where the naturally packed head
ends with u32 seen):

Old flag area:
  60..66  7 bools (nospec through call_with_percpu_alloc_ptr)
  67      u8 alu_state
  68      u8 with three bit fields
  69..71  3 padding bytes
  72..75  unsigned int orig_idx
  76..79  u32 with bit fields
  80..131 u32 scc + 4x u16 + u32 const_reg_vals[10]

That gives sizeof 136 (aligned to 8). The new layout removes the 3-byte pad
at offset 69 by packing all flags into one u64 at 60..67, followed directly
by unsigned int orig_idx at 68..71, giving sizeof 128.

Could the commit message be updated to reflect the actual delta?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35821138073
--===============7930006386070302406==--
