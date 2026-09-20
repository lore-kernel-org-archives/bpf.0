Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1933F8BC;
	Sun, 20 Sep 2026 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789899544; cv=none; b=pU2Pi5Rre7XL9rSu8pGuYP075TDtMczz4ssLXMuQX4xzSVqZ+B/Gw7cOmzMs3fIqGkactyVRKUK7n6hq3zDO7+5FAMMwsg20YVfHN0otZsPzeSOnfEV64krrFzwT/3b0OPBDSt8HZPt8cm9z4E57PXi4encJ+VCfq8VDDkM3adU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789899544; c=relaxed/simple;
	bh=FpmRis21Ag+zP62e7sxqkkR2g1hEjS59FLq44DoFHmQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ASnRBcmAriMhe6FBgaqNFMorRdAdZAYtQm5f+NlyG0+ZpPARNVG8PJ0coEj+IOIqzYNwBdYxddwI/laHQjOZY3o1zInEhwpcAEIzCf9MrvkqehReHQ6AvPnQI1i0bDEIkio1QZwx5n3GaIQSkyXi761Fc4oYI7OwlHOEmXztqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNM8jM0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNM8jM0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7765C1F000FF;
	Sun, 20 Sep 2026 10:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789899542;
	bh=FsLiV+oJcbrN0HciTUZGpqPAIsc8SzElE9QMbUUfSd0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fNM8jM0CYhAzMkA/psasqrfJ5j/4OAKLQnRctxcn4Ot0EjWlE5IqMrw17TcKm/tb9
	 PecnPe6qeJIuoJUe0PhzsNnOgtVuWOK00TWDrNYxdqcad9Ge2SMZ/rdXg01qNwcf2B
	 Gs8GaQY9DFCi/+blvlxfZ8E61R/aywDpuvo3LEfKUyVwvsUIWhzJeseSugU1KOl5NC
	 dGYCnPjwdXY3gQgjPxUVrDIxuNtkObHdT5B3RPqxnfM1SBml2heOadw2pTp/+LhGnp
	 1r443XniCUzcn1u4hyhl4h49t9TYIvcVfbClbQkC6xLwA41y8T2P15Lm2qOlPsWB67
	 0XvWmIG+UUplg==
Content-Type: multipart/mixed; boundary="===============7629753069469164343=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eeaf9112a1ba86d1cbfbd5287cc67bcc13adb07861cced93eb4c51167758b3fe@mail.kernel.org>
In-Reply-To: <20260920093153.439743-2-donggeunyoo.kernel@gmail.com>
References: <20260920093153.439743-2-donggeunyoo.kernel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash element
From: bot+bpf-ci@kernel.org
To: donggeunyoo.kernel@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,donggeunyoo.kernel@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 10:19:00 +0000 (UTC)

--===============7629753069469164343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 4f495dcbf670c..c4683d0e4c149 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1056,12 +1056,12 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
>  	 * known initial values for cpus other than current one
>  	 * (onallcpus=false always when coming from bpf prog).
>  	 */
> -	if (!onallcpus) {
> -		int current_cpu = raw_smp_processor_id();
> +	if (!onallcpus || (map_flags & BPF_F_CPU)) {
> +		int init_cpu = onallcpus ? map_flags >> 32 : raw_smp_processor_id();
>  		int cpu;
>
>  		for_each_possible_cpu(cpu) {
> -			if (cpu == current_cpu)
> +			if (cpu == init_cpu)
>  				copy_map_value(&htab->map, per_cpu_ptr(pptr, cpu), value);
>  			else /* Since elem is preallocated, we cannot touch special fields */
>  				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));

Does the block comment above this condition need updating? It says the value
goes to the "current one" and explains the whole branch with "onallcpus=false
always when coming from bpf prog."

With the patch, the branch is also taken when onallcpus is true and BPF_F_CPU
is set. In that case:

    if (!onallcpus || (map_flags & BPF_F_CPU)) {
        int init_cpu = onallcpus ? map_flags >> 32 : raw_smp_processor_id();

the value goes to the CPU named in map_flags >> 32, while the current CPU
might be one of the CPUs that gets zero-filled.

The rationale also seems specific to the BPF program case. For BPF_F_CPU
updates there is no BPF program involved (htab_map_check_update_flags()
returns -EINVAL for !onallcpus && map_flags > BPF_EXIST), so the reason to
zero the other slots is that the per-cpu area is recycled and must not hand
back the previous tenant's values, as the commit message explains.

Could the comment be updated to cover both entry conditions?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35502758763
--===============7629753069469164343==--
