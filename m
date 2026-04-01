Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E3363087
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775037459; cv=none; b=oVnfjk+CnLXLxZdqUdhfkxgIDNWZBCkXrlXtw41laLig+HB6DuGEZMolbAdU7ph0mg35va5dTI/XdrddbrjZNdhpBAv9PKcPBT+cAFPgvTDZsHwMczm0DkEsdFD7YJ8PwbyQGqZbVD1atiRhfm1NiIl0LomY1c44CR4eGKyg+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775037459; c=relaxed/simple;
	bh=+iDpJXBALYRNSiXsLWS2uoU+0TbeRklPCUEuZVLeh7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxsq9+yj+x0fU4XtrkjsP9gtQkVwLjR206hK6F0HbhjFmTQjTqNp/021N9x05a2V3yY11LAzfVw3HMBAI6eBMlfSf4e6k00sxkatMwp2BM9JcIYn4uCf5R6l7zQjX3EeDPzbj0SmKro3vvvVMNXivWtYR2BtHv+2QhVD8/1s5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW11/znt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW11/znt"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso3328746a91.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775037457; x=1775642257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uyzxBw7QKCfEyQ+SqW1ntj1GkCAU7kXKz3YfdBWpbPc=;
        b=RW11/zntb7mv9t8UX12aE6RsJyLKyTHvYzc8QZLdaUbYtM6gtUrzsOI4KzdAYWlDAq
         SLD9kd9vX3Nizx8CPmdMUV1CUgrwGa6hFgFY0++wiIKfn6WUa/Pd6Wrx0G8XySXKiuLl
         ZxCjABbtGTQQ8VkdInX9Lyeei6xMSUhI6bs50IkHzHbkGxo7lSwDfCQ8c5JatbTwLHy8
         4MqiNYMx3KzStrNN/B1Gdh3cynwewIvGVFoPp4VSaXFZDMomfAiNblR8t9ClZbxTNNYA
         xrtaLmttpNg1+5rQnQ1IWC27VB+Yx7m8NZoCprp2FZSM+qgbYtIlFJk0k0UDhD2RNYR9
         CCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775037457; x=1775642257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyzxBw7QKCfEyQ+SqW1ntj1GkCAU7kXKz3YfdBWpbPc=;
        b=KnoqqiwdgEx0UJgY7iJ84l+1+OS77eUVaz4yzjKwmwzvwXafxIRbjqFvDNU0vMAiEr
         R62A4J14P640G3E92Dh20bOERPsJbhU8y4idHsZl+PwhVXDVWS/puLUcm74agH95Rzof
         w4juctghuatzYS4Q/aqgcfp4gHwq7xqPAz+m+X1W3DvHVXGAe63LDBVSnORRoRXjRhtI
         +kcg2H+PuLBiyrQQCM4PpynmNKzRzU968BD3EcjtFbphHkGg5FBRYDvfPhtduKY69g68
         VTfI99BqfpSyuTDObrgovbdiAXC7q3MOCdjbVvmY0K33407AEIULqBmn3MS1VvgrjdX+
         eAXw==
X-Forwarded-Encrypted: i=1; AJvYcCWnGXIScmaEYqLvLlIfwcq/LrO+KS1I1JwVosZVkmXJNerbNLgjqUNPg+3STUITW/yudBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMYNrPJ7FkRtyPSS11ZqzSo1HrhKBCPe21dfwbs5HkwyTWm2wa
	8/NZcVkFynXoQNy1SRIpW+26TSEvJj9HoVeZHVl+6DvlJh4MZnhgUW/Z
X-Gm-Gg: ATEYQzxg6I/esjINpUekFwfOFGS8lsY+apoz1FeoKxJf0bDvx9RcUD57Qp3VPPYpTET
	Z5B9GCma2bPexSkqx/2+OX/hP2agRAnBqSop6dfJKMcq3Um0g9Pw8lusUWdZW5PEP3SUmOHN0gq
	4uD2KCKNtzRRXCw2v2KHIWLEcn2NJbnnFhD7zbF5+/7fJpqueAULIOyV+b8/M6E0+CiN2y3rE1r
	YSP8+yZGZDKTi5GzLyfpDzyv0+t/g3K8JDgaECfOQfhjMx8Hk4h+9Yexj695BbXIdYXoRAO8CMj
	t6d9j8dRpggnNCFyRfI0b8vSx01diBNTEUmUP6rUs0Ax5AEj50xX1NM5BOLovHK3KXi6mLLJIeY
	z0B4RRFxb+qwtc8lskeigIrYP+nyrZLnM8/XkqMonc4SXTFWDrNOfS3SBwcap6EzqGsAVlly6aH
	rZmPOOm5/xfARA0HlKFRKe/tVF/CvJESXYZddXetfG
X-Received: by 2002:a17:903:1246:b0:2b2:42da:25cc with SMTP id d9443c01a7336-2b269a95f89mr31039555ad.1.1775037457330;
        Wed, 01 Apr 2026 02:57:37 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:a82::10c:35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242765d3esm187298735ad.47.2026.04.01.02.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:57:37 -0700 (PDT)
Date: Wed, 1 Apr 2026 15:27:25 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: andrii@kernel.org, alan.maguire@oracle.com, yonghong.song@linux.dev, 
	song@kernel.org, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, eddyz87@gmail.com, martin.lau@linux.dev, jolsa@kernel.org, 
	menglong8.dong@gmail.com, puranjay@kernel.org, bjorn@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 2/3] libbpf: Add FEAT_KPROBE_MULTI_LINK
 feature probe.
Message-ID: <aczr0qrzfyQ0jHsb@computer>
References: <20260330110019.549079-1-varunrmallya@gmail.com>
 <20260330110019.549079-3-varunrmallya@gmail.com>
 <0c82df11-2dc8-4828-bcb6-29114ba91fc6@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c82df11-2dc8-4828-bcb6-29114ba91fc6@linux.dev>

On Mon, Mar 30, 2026 at 10:42:57PM +0800, Leon Hwang wrote:
> On 2026/3/30 19:00, Varun R Mallya wrote:
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > index 4bcb6ca69bb1..633106a687c7 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -388,6 +388,8 @@ enum kern_feature_id {
> >  	FEAT_SYSCALL_WRAPPER,
> >  	/* BPF multi-uprobe link support */
> >  	FEAT_UPROBE_MULTI_LINK,
> > +	/* BPF multi-kprobe link support */
> > +	FEAT_KPROBE_MULTI_LINK,
> 
> Even though it seems good to put FEAT_KPROBE_MULTI_LINK here, better to
> put it at last to keep backwards compatibility?
> 
> When users compile application using old libbpf and run it against such
> new libbpf.so, will they get incorrect feature support?
> 
> Thanks,
> Leon
Changing in v3. Thanks!
> >  	/* Kernel supports arg:ctx tag (__arg_ctx) for global subprogs natively */
> >  	FEAT_ARG_CTX_TAG,
> >  	/* Kernel supports '?' at the front of datasec names */
> 
