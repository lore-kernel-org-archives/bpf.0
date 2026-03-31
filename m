Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432B3FCB3A
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968999; cv=none; b=kiZqEKv13tM3d5Rze+JSU/tf271QtNZTmYd64dR+4yCbXAGO6JgJ7nUsnOi2z2ycqMhNhUjOITih9MmrgPizuFWYwi7VffTOJkQ+yaAkuiABPQ8Hk48jx5ep7Cin5XvGlpV9uRtBU7I3kjm/J+nkAPYDxvX4KUAoxD+KjaoRaVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968999; c=relaxed/simple;
	bh=rNwyT+z5PQbe6y9eImmq1rXxFiKD8golmLkGTvWwb1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD+FVhrwlneWLnj3BPKK5hcDq2Hamt6b0Zs6zIdekEVi41e0ecV23dUyLhtr2gnZOgpx2HQslDlXjWldCvCplE0VQH1kgZaN8+Fha2FzbBjCo3EwgVz/z0SoG8z/hal74XGcLxJTU2L8XXLg7G194yGMirttszglk2C7+G1xQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzpeG9WZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzpeG9WZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so6791005e9.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774968996; x=1775573796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2a+uehkJHEo/falxOOLr1RQ2/7BxCwQ0UvNZcdh8Dyk=;
        b=nzpeG9WZuiNBxDrgWosCpvIZvGbqerABCwPOrPWK5zv1jPZ5TA3U9zB8H7ZjwGFnXl
         hMvA4V29Q0orOQLlkcb+kgrYzeOdx6iRmbqORGWP2wjwyTxJKYYBaKyhGGnEP9XRjjz0
         fwl1Kbe7D0WgkpXdqVWv8HgBkp/SpQYNXG/rJPF2ni/4MHr+v6YnPEqg139EsyAG6+kK
         5WiMXZNBMz1iXgcdQslpPKM/uOIMSSCPCnNyJJn3tdnIDXjmY/JWOoG2Z+YiQNS/Ukyu
         1/EB+RukRaZp9fd1Ku/Bg4o3Ti5enm99LA/mMzl7YiObWLjfUaoHyxgXg3iD5ovRM9CM
         lXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774968996; x=1775573796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2a+uehkJHEo/falxOOLr1RQ2/7BxCwQ0UvNZcdh8Dyk=;
        b=TfUIS1wLYQUBbd+Tyoxb0KBQf1PezIS1wZeZorxvj9oRiBM0DR12kWLTntFIHb/VCc
         PEOFKUKjIxPI1NjsYnZ0ZgmdXxzZdaAkwVSTUV5rToVm2k4NuPh2GHx68oNT5fzBm2k1
         2UKWai7k2/pCMuQ9h6WC/JeeqLSZ8ge1b6r8CjzQjPN/NocrwitoM2cKsq+HzN/ghIZz
         m9JQfxOAfh2g0LgkCPvyt+bcbM2m67OnQn0T4O0Ldwq3Tr6ztw4fNdxrzp0fptc8vky6
         lKTpqzaxE/8WNKPtVG0gs114kOEUpyPu3+Ip7rO7zBeO5cZ2Ish3FuX5mXUd0f4G3yQT
         PQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbSn1o8hxivEGOfw1z729XqlWRbku3PmLvNCqi4TrMojEcijK8sq+sKl6IeHoSOE7j0aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFPb2pxuBEernnxeg8XjaOitnfoT83o8t5nGx6cVZfzu89Kssq
	DN6b+QPvGSbRDDX1v+Y8CJ4lWDebTvsWbHe7E8GBO6w7ZnvsViTZQ2TJ
X-Gm-Gg: ATEYQzxs4hIImuro8F5IKOFimwVbCfI+gB28gJr2OBo6R4XJ9f9C2Z+3QZ/eV5wv2ox
	CSb2nduDPRC54V2X3TwHxyT9qSwl7c5qxSPmETaThG3bwq3BwsRm6+upXwXuaPlLmEv0jzEjxgL
	tpbE8n+ZyhAAdd9c3G4B7lpDJPUv3Qwt8IzSbVwf0aXyyZFu44Hp/BWAfWpnrT/Bxecwhs7T0Wj
	j2fjUm5GLcmxujy2Lnu2RAB7RkLKVov7XmVPeiToex+ic9vpsLodQSGbcXhnSsZYdRtBVa24v0l
	SaCaAuqhA/IRkUc6Rtxml7xIJISdoLGzQnsGXgDes+FtGuQChCo2hOEhCvdb6zo2OMtMHBih306
	TB2Wu45xIpIe+A9WYaoespMdJeC0L2XZNPDLmgZ/f0PjXCu4w1L7Ir70QRsmoShpGQqEoFqxuvL
	Czp+c4yK5aXqAMcIlaQAtW1//tgNgi/WfPT10+gXdFvWxTXe/Wx96YH410yrg6UviYpTdLdi5Kn
	RSSsehgSQAfuELm4nwRda0pp4Fd/p5JtCsVBpUA6ODdAK0wrbD8WqllpMCiPwdYE7pmkjMcqjft
	FPgqyDk83XXqwNhNLtuNP7wt/M2/U45LvRCkwXw4wrw=
X-Received: by 2002:a05:600c:8509:b0:483:6fe3:bb49 with SMTP id 5b1f17b1804b1-4887810ff5dmr82883255e9.0.1774968996082;
        Tue, 31 Mar 2026 07:56:36 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00da01a826f734293d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:da01:a826:f734:293d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2577cbdsm28692442f8f.33.2026.03.31.07.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:56:35 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:56:33 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: KaFai Wan <kafai.wan@linux.dev>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: Use bpf_verifier_env buffers for
 reg_set_min_max
Message-ID: <acvgod1Tnih-EAoO@mail.gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <9fdf9830803fe3a5c4059341c84a03836105f5bf.1774025082.git.paul.chaignon@gmail.com>
 <33c006d7275cb443b5750f062cb78c38449a7537.camel@gmail.com>
 <acpnHDASo5QGw7BZ@mail.gmail.com>
 <d766f85ad5617da8af16a64f8903edfa3442e6d7.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d766f85ad5617da8af16a64f8903edfa3442e6d7.camel@gmail.com>

On Mon, Mar 30, 2026 at 06:51:04PM -0700, Eduard Zingerman wrote:
> On Mon, 2026-03-30 at 14:05 +0200, Paul Chaignon wrote:
> > On Mon, Mar 23, 2026 at 11:42:11AM -0700, Eduard Zingerman wrote:
> > > On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:
> > 
> > [...]
> > 
> > > > @@ -17196,30 +17192,23 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
> > > >  	 * variable offset from the compare (unless they were a pointer into
> > > >  	 * the same object, but we don't bother with that).
> > > >  	 */
> > > > -	if (false_reg1->type != SCALAR_VALUE || false_reg2->type != SCALAR_VALUE)
> > > > -		return 0;
> > > > -
> > > > -	/* We compute branch direction for same SCALAR_VALUE registers in
> > > > -	 * is_scalar_branch_taken(). For unknown branch directions (e.g., BPF_JSET)
> > > > -	 * on the same registers, we don't need to adjust the min/max values.
> > > > -	 */
> > > > -	if (false_reg1 == false_reg2)
> > > 
> > > A side note:
> > > 
> > > The above hunk was added as a part of [1] to mitigate some invariant
> > > violation errors. Surprisingly, none of the tests added in [1] fail
> > > on current master if above hunk is commented out. Probably due to
> > > recent improvements in bounds deduction. Should we remove these
> > > tests as a part of the series?
> > > 
> > > [1] https://lore.kernel.org/all/20251103063108.1111764-3-kafai.wan@linux.dev/
> > 
> > Nice catch! Out of those five new tests, the three "jset on same
> > register, scalar value unknown branch" never fail if you revert the
> > commit they were testing, even at the time they were added.
> 
> When I get back to [1] and revert [2] I see the following test failing:
> 
>   verifier_bounds/jset on same register, scalar value branch taken
> 
> The other two indeed pass.

I think we're saying the same thing :) My always failing tests are those
ending with "value unknown branch [1-3]", while the one ending with
"value branch taken" indeed fails as expected. I also forgot to mention
before that "jset on same register, constant value branch taken" also
never fails.

So to sum up, these never fail:
  - jset on same register, constant value branch taken
  - jset on same register, scalar value unknown branch 1
  - jset on same register, scalar value unknown branch 2
  - jset on same register, scalar value unknown branch 3

While these fail as expected:
  - conditional jump on same register, branch taken
  - jset on same register, scalar value branch taken

Are you suggesting to remove the first four?

> 
> [1] 9f32bfec545c ("selftests/bpf: Add test for conditional jumps on same scalar register")
> [2] d43ad9da8052 ("bpf: Skip bounds adjustment for conditional jumps on same scalar register")
> 
> > I believe
> > these three tests were intended to cover the above "false_reg1 ==
> > false_reg2" check and supposed to fail with an invariant violation when
> > the check is missing.
> > 
> > I believe this check was never actually needed. For an invariant
> > violation to happen, we need regs_refine_cond_op to refine a register
> > based on a incorrectly-detected branch being verified. For jset, that
> > can only happen if one of the two registers is constant. In our case,
> > that would mean both registers are constant. But if both registers are
> > constant, then is_scalar_branch_taken is always able to precisely
> > deduce the outcome of the jset. Hence, we wouldn't even reach this
> > "false_reg1 == false_reg2" check.
> > 
> > I think I'll remove this check in a preparatory commit, along with the
> > related selftests and an explanation why it's all not-needed. Cc'ing
> > KaFai Wan in case I missed something.
> > 
> > > 
> > > [...]
