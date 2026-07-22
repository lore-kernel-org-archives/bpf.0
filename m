Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2A478859
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706271; cv=none; b=WIxlHShn2+EcLrFadMDb+m62zUvWNWpM8PIGX/adhzWlpzGWqcLJbft3EmGPig2rIoUYt4B2wP5W2H941HVTFTStf9QOf9zGoJaONDoOZ7Xofd4SYc1wTCtWXiLJhCEEkDFpOnu9c64jvUA9w2/SlC+XAEfwjZKtI88F2XKbZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706271; c=relaxed/simple;
	bh=hvvZZ9WnDamFt2nH8Wj/UMAMyTXKq6pATnBAsjabcRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKCrgb++K+aMQ2GD63c7L0rspNBx96DEUKhLElxYzNRfdCJ9ag0NBDKsZDLSNXDA72jUDsit4UXM3uHykXmLGq6ytLhHzOc1fC3+RAK8eYqvP7ZwWSABr1YX1LLQW+G9FNlbJGeuOu3bfD7Qhuwsf03UwU8+85NBGPV0PiWzziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VHwnIyGG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VHwnIyGG"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15f360851aso1350849366b.2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 00:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784706266; x=1785311066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jF6485LeRKPydpaF+R9Ey9azSDTe9cIW9VnQV5w/95g=;
        b=VHwnIyGG2cMfX/7dU/WUpxk8REmgAxOiDuoSao9663xJeJWum0bLZNHmiHSmv6stAv
         +TTEXTt4vnA1goRg7QXr7DEoSGKkJUGmYWwjQLm+B0POFG4jzvRzrNyvdYq25yxDxDEj
         PjnhnWVzKdRIbbYhs4hsZF//rJDobDfswnGDosGJd2Mcxd7OiUUueZkaYqCoGbAHWBzw
         etSRmmgp2SQtFVvAukJhA/W20GFV+MLv8wDm2MRM1EZDUk2oxPYQ3XtmrkN58DmwgqB0
         fwj4mSWrm1Rg8YUPi6aEdgx7kBkTbn6z//4bwofRFHnol9C2syeI/rzv0C0vWD+MnudF
         hxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784706266; x=1785311066;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jF6485LeRKPydpaF+R9Ey9azSDTe9cIW9VnQV5w/95g=;
        b=BUU7qlzwfFnTXmjYzl2SMLNNqcm15RaKz0EyllNTQ/XlaXlsMLB3PxYej3KQDjjCNd
         9Ijy4pb3uw8zFuTRD/c2J+NR462eEtOdi2+zIhkonxBxGrAl5YNUrs9VFtp6FZxIgEGL
         CSTI0n0xF8x1+sNbtsG1QpxoW5r74j2s9WGqP0719stzGb/oJaDS3p8NB8hihSgitvRV
         AtUEvINIqvzytKNhtfna503++JJJdfYrrLMGgvIjinoBJbY6IE1P8r/V6J6DrIsiIBip
         UTsAKjKN4zDs/WPSyutZ+Ij9peYAfCjFoBnqgq39NX0/AN7gQDgYudRFyiOnTp1KNMyT
         GQKw==
X-Gm-Message-State: AOJu0YzdtomA9eQGD765BpN7NrEEzOpgwxeRSOFERU6aRK8zSaUsMoa4
	c7m+eAy1SvAKugeQAFYJrYF3x+5Qs6oHhGcViWgsSrijAlFWJ0OSGjZCgz20gzmtP01CA/CO+RF
	vc6e+sEdH4A==
X-Gm-Gg: AR+sD10LdVCY9KraKJ1g5oIZ1Lqm1mLvKHM/+fhP9V1n2hK5pJrtATdtyFpghvhV+3X
	6UYLPRY9U4xXXdFuuo0HGEt+WvG0z6TykWPluGUNze7Kf3SWoyAveiPoaobSayiM/vpnlChTvum
	b40ee0iaNzzro/RhK0AAX18zJc8e7R4w7+aA+Ugw42zlwVuLMrYnTfFzhN6+SeQ1QYPvE48e1Y5
	7JFqKr25RhLW1JfCfPDIz8A9YqfmWbJd6AgphFHYmSkZ+L3xBAgBpwHYvEwqZqYL/ugyBkbbrTk
	kOMDKGkoG0dZ8Bd5YlfSGp43PXR6cY3ptVdwgXMF7qyKkNqNanOx6Yu8IlsojeFjPyV3qd9lvqP
	SC47xqI5hFsPjpYsVrt0fEs5tWg6Xy2KbCJeaHuCg1BpJ6DGi35BsmtmP8OAj273MaQbcWApYvF
	9kN12y3tdnWGEabHjEUZcKPl00
X-Received: by 2002:a17:907:3f99:b0:c16:592b:ec4c with SMTP id a640c23a62f3a-c16b46990d8mr908620966b.1.1784706265503;
        Wed, 22 Jul 2026 00:44:25 -0700 (PDT)
Received: from u94a (27-53-137-220.adsl.fetnet.net. [27.53.137.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa9918sm9950635ad.16.2026.07.22.00.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:44:24 -0700 (PDT)
Date: Wed, 22 Jul 2026 15:44:19 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, 
	sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] bpf: Preserve stack frame number for commuted
 arithmetic
Message-ID: <amByrnAG0NWd0dLK@u94a>
References: <cover.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
 <a092a059781aad37b8d8ce3bb927052de5f73431.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
 <20260721094829.3D0C71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721094829.3D0C71F00A3A@smtp.kernel.org>

On Tue, Jul 21, 2026 at 09:48:28AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] The patch completely breaks the security check that prohibits subtracting a pointer from a scalar (`scalar -= pointer`), allowing unprivileged eBPF programs to bypass memory isolation and achieve arbitrary kernel memory read/write.
> --
> 
> --- Patch [1]: [PATCH 1/2] bpf: Preserve stack frame number for commuted arithmetic ---
> commit 3b8c2832d6eb05fc6ef4d1f2af9ee96ccdf5566e
> Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> 
> bpf: Preserve stack frame number for commuted arithmetic
> 
> This patch modifies how commuted pointer arithmetic is handled in
> adjust_reg_min_max_vals(). It uses a temporary off_reg to copy the
> destination register before calling adjust_ptr_min_max_vals().
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 52be0a118cce0..3c0af83db4672 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -14854,15 +14855,18 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
> >  					bpf_alu_string[opcode >> 4]);
> >  				return -EACCES;
> >  			} else {
> > +				struct bpf_reg_state off_reg;
> > +
> >  				/* scalar += pointer
> >  				 * This is legal, but we have to reverse our
> >  				 * src/dest handling in computing the range
> >  				 */
> > +				off_reg = *dst_reg;
> >  				err = mark_chain_precision(env, insn->dst_reg);
> >  				if (err)
> >  					return err;
> >  				return adjust_ptr_min_max_vals(env, insn,
> > -							       src_reg, dst_reg);
> > +							       src_reg, &off_reg);
> 
> [Severity: Critical]
> Does passing a pointer to the local stack variable off_reg here break the
> pointer equality check in adjust_ptr_min_max_vals()?
> 
> In adjust_ptr_min_max_vals(), we have this check to prevent subtracting a
> pointer from a scalar:
> 
> 	case BPF_SUB:
> 		if (dst_reg == off_reg) {
> 			/* scalar -= pointer.  Creates an unknown scalar */
> 			verbose(env, "R%d tried to subtract pointer from scalar\n",
> 				dst);
> 			return -EACCES;
> 		}
> 
> Since off_reg is now a stack pointer from adjust_reg_min_max_vals(), it will
> never equal the verifier state array pointer dst_reg. Could this regression
> allow eBPF programs to bypass the restriction and execute scalar -= pointer,
> potentially breaking memory isolation?

This seems right. adjust_ptr_min_max_vals() has the assumptions that
either one of these cases has to be true
1. off_reg == dst_reg && ptr_reg == src_reg
2. ptr_reg == dst_reg && off_reg == src_reg

By passing neither dst_reg and src_reg as off_reg we're breaking the
assumption. Perhaps we should have add a ptr_is_dst_reg argument for
adjust_ptr_min_max_vals(), which could also then passed down to
sanitize_ptr_alu() as well (which currently computes ptr_is_dst_reg
itself).
