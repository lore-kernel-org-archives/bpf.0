Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181C13C1D4F
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541777; cv=none; b=CfM4Sdyn8rxGwCcEZ6/vL1Lrh7hNhY7qId9ajux01wVSAMUWUv8EV+ZPplpdCT8O26Rs0Vy+vEianK5SZhXNSAk/aNvbNV+5NyMEaIXmCldqn9pvzSiOOEoivioA3+gJf8bkBxuRXVGzmwyGDDxfuQsatGgy8gOVUpgpeI8T17Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541777; c=relaxed/simple;
	bh=nGjyLqkiwoU4k0FAHUD28WtOEPGJyOEjkf96tnMK59Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jraT7jBZADHPEBurHyjf5HxqWn8fzJMibTQ0Pj3BK9OvTbUimIE7JE31y727CL2dyIUdci4PCiRfYBfeS+5YJu6BP7kR7FfeWr149A+yxma6sIKlHtDMoVXgfkkvTYkm9V5J9sL92grCQdkvfboPn3G45sDc1kgR96COlij3wVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhOw+Jvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhOw+Jvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F295D1F00893;
	Sun, 27 Sep 2026 20:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541775;
	bh=1cWg1psdg3LkG+k++SkKuhzlAZeQPFEbyYb0HDPgrsA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fhOw+JvtXiiA33u2ynQD5bg9NMnaPY7DQipspyenQhr+1TvCTgpX6VFKAMzEjeTxI
	 asGg/i74hALKfCAjrF71D27HUTbZGsmzzD37uhGdb+irR+0t+ab/O86HII4g/6MRVJ
	 pbWfwYb/3UTAwX3R0au9fcbTCnzgbNkDCDX5ixCpYaM0Lk4S637MJ+jgv+G/Y5Gs6q
	 W4YnHhpJql7Jtac0Zb5Q3w4aLgQMR3vRS2r710R3xO84/1L7goiqa4Ytj6322xSnFM
	 ULPXzAImomFxK6bbq1/k4dWx+5L9hgvN+Hxj1KpJjEVg8rmxbVej7BV8h/AxoYwfgp
	 hlpEGs4svwW3w==
Content-Type: multipart/mixed; boundary="===============0495186862761792865=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ac658f0d231ac7f982d3f5433eb9fa45d9a5c41212fef101f4d6e10f48e5908@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-13-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-13-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 13/36] bpf: allow subrange relations for PTR_TO_STACK in regsafe()
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:42:54 +0000 (UTC)

--===============0495186862761792865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 18bf7b660c2f..29d18520d27c 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -608,12 +608,17 @@ static bool regsafe(...) {
>  	case PTR_TO_MAP_KEY:
>  	case PTR_TO_MAP_VALUE:
>  	case PTR_TO_MEM:
>  	case PTR_TO_BUF:
>  	case PTR_TO_TP_BUFFER:
>  		/* If the new min/max/var_off satisfy the old ones and
>  		 * everything else matches, we are OK.
>  		 */
>  		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
>  		       range_within(rold, rcur) &&
>  		       tnum_in(rold->var_off, rcur->var_off) &&
>  		       check_ids(rold->id, rcur->id, idmap) &&
>  		       check_ids(rold->parent_id, rcur->parent_id, idmap) &&
>  		       check_ids(rold->map_uid, rcur->map_uid, idmap);

[ ... ]

>  	case PTR_TO_STACK:
> -		return regs_exact(rold, rcur, idmap);
> +		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
> +		       range_within(rold, rcur) &&
> +		       tnum_in(rold->var_off, rcur->var_off) &&
> +		       check_ids(rold->id, rcur->id, idmap) &&
> +		       check_ids(rold->parent_id, rcur->parent_id, idmap) &&
> +		       rold->frameno == rcur->frameno;

This isn't a bug, but the new PTR_TO_STACK block copies the first five
conditions from the PTR_TO_MAP_VALUE/PTR_TO_MEM group above, with only
the final check differing.

Since frameno sits in the union before var_off, the memcmp() already
compares it, so the explicit frameno == frameno check at the end doesn't
change the result. The PTR_TO_MAP_* group's extra check_ids() on map_uid
wouldn't affect stack pointers (map_uid is always 0 for R10-derived
pointers).

Could PTR_TO_STACK simply join the existing case group above instead of
repeating its conditions?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============0495186862761792865==--
