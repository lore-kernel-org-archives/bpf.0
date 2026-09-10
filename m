Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE743783C7
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 21:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076718; cv=none; b=Wkz6CS+TQ4fwleoKWMWD+j1Vi6YTEICtlJ56+kHGGIDq44Jzfbw+PP1xhUG8JMaYku40W9pum5P449JFqKR4pd3y7/GbEkTEWB6XmoZH+C6k2PRrVJ6fXpGfjyNL/RwZiPC2z4489qYExxWD5LjVUZi7UUb4iuSQ3WwkURNdLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076718; c=relaxed/simple;
	bh=9Tge4+yBpgYIjVhptBGIG9hcUVp8xnG1oGVrhtMXn5k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZGL1gpcTZoL+COjfYdhnldny8XmMQVTe7W1vnJcZpnlsdQsmRnc+kJFxf7EMr3njWSQqgVzDnyCjRJ0DHd7hpvWycqX+4CIY+JAS6eFljw68/LKDbi+dmDGhSoWX6ICfzR2Jf9EJlIKBcQIhIuvzlCfSarydIsT/2Auae3oD1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULahD+Ra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULahD+Ra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594141F000FF;
	Thu, 10 Sep 2026 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789076717;
	bh=oaagPJ3UxbFSgdgS39pWtgEA/tK/Lm7Lp8yOuSorLFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ULahD+RavvYftCCJcFpQZfDB1h4gyTb+BLGWaBw3fncqsgL3VoaCNSC/gBwSCYlaI
	 knGmtlj36R0iHD3IihrltN0ouxYRK4TimplnmDW9hb6/izAFbMEqkJuPdx//rzNB9A
	 q26sc0fzh5hQCQtmDB8bFIFZlOgzTczglwiZ66qU1uMKGUooGzch6VvfBAVOFq8Zqw
	 9OyuDlmqfSByyUHJwOdGvQkOTbvUl3RaOVqTmsG270eVOpQUHeP757sGVWmA3e3GT4
	 BUqet0slAsEPBn8Y7cYMOfl+aMkrYjIBageVnIZrUkV/chn/TN5UGP0uETg7LF8LFJ
	 MMjOjVdUgN0wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/4] bpf: Require CAP_PERFMON for kfuncs reading
 memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910213510.49358-2-daniel@iogearbox.net>
References: <20260910213510.49358-1-daniel@iogearbox.net>
 <20260910213510.49358-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 21:45:16 +0000
Message-Id: <20260910214517.594141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check for negative enum values in `bpf_mem_cgroup_m=
emory_events` kfunc.
--

commit cdc4306f1568d5f9112eea54321dd73200076861
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Require CAP_PERFMON for kfuncs reading memory

This commit restricts several memory-reading and fault-safe probe BPF kernel
functions (kfuncs) by marking them with the KF_PERFMON flag. It ensures that
these functions, such as bpf_rdonly_cast and bpf_get_kmem_cache, now require
CAP_PERFMON privileges to prevent unprivileged memory access.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
[ ... ]

While reviewing the BPF kfuncs context, I noticed a related concern in
bpf_mem_cgroup_memory_events() located in mm/bpf_memcontrol.c.

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a negative
enum value to bypass the bounds check here?

mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events() {
        ...
        if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
                return (unsigned long)-1;

        return atomic_long_read(&memcg->memory_events[event]);
}

The BPF verifier allows unconstrained scalar arguments for enums and does
not enforce enum bounds internally. If a BPF program passes a negative
integer as the event parameter (such as -1), the >=3D check evaluates to
false because enums are treated as signed integers.

Could this lead to an out-of-bounds read of kernel memory when the negative
event index is used to access the memory_events array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910213510.4935=
8-1-daniel@iogearbox.net?part=3D2
