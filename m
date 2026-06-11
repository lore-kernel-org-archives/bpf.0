Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD323BCD0B
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170654; cv=none; b=rhLVihhO6wkX36h0zHmidd0iXp1iGeCu5CVZdIQAHH9s8r064oU0XQJ94g0DLhc769LbKucj7dBjw1YwHJV4jNTB5C4c9Iulb+GXCLJHisH4iI4Ss6UuqyovPToZZz9VxUwAo5uCivElxG7h+qg+c9VLPhNUMN7TkHTGzQeD9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170654; c=relaxed/simple;
	bh=wA+twUEFzsAdwFg4SjCBQ9q3jy94DJz5Ve4/QlurBos=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkGDQ8TIO7b+g4mRDe75+Sm1cGBUXpejpSiLBX6gqszBsih8+NIxGxEl/S/AcX8rmxJCb0F0nI3enkeY75oz4asP2h3qflU6vksbsxZTL6ydcwwp/L1trRchscYE3me2VpPC4D+iIVCvwyITHnWhqR/IaWFZNPO0RJ5mQ7PFViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQY/ERYN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQY/ERYN"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4602e2a0372so5702839f8f.3
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781170651; x=1781775451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vEO8kje9kYrRQU/+kV8ArVqyL99RuYg/7cQwFotLr28=;
        b=NQY/ERYN4jTPHy6OFUUcZkVCLlTGg3WU81V5EXeunZ/MxbN0Z0L6JxEnQa6eHljUb6
         opBXqMnrIfT+hDcIpyrlj0mRrgFh7zupv++oTwd0w1VSLVMVZxsLoN2/cTIam21oQZ1A
         nTMeYdbzfydxHwMAJ1+iDd9nXnFf/0obvLojBOLiJkFHxkVKzHaZNy+Qb+BQJ/bDkCic
         0MB2rvfpppfGpQs4lgO/xLM9d45mjPc1ctSYUZCqlSKBglrtpC1n6Obixg0h+1m09S9R
         oWHt2GmYxSHh1fg4pyLK7VpT2qYqP18NzF6rpKhofKmDANi6Bf4uwVJ/4b+1u6WG8cs2
         e84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170651; x=1781775451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEO8kje9kYrRQU/+kV8ArVqyL99RuYg/7cQwFotLr28=;
        b=bppsgaydoerg/tk+b1CGhU+cEyn7JDjE71CMEo6JIvd8igXVfOaSmfoU2divlkL1rH
         HkG9gU8SuFB2FJJpgZt4kxmCbkzRr7TElstb6775eTtL7UMqoMfY6Vn0s0AbdK5XVQcr
         dJg7+e4+o+3TBbXfmu/WGd6NBa5f++cHNVZjd1ODQlFb+5qWwa+8YdW+cYXfKdo9ler3
         RnYHYBMtCLd3IxIB1B/9wd31eUBlvzJi5l+qFHnwz3k6FrM7g2u//cqh3FmMyW9Biqb7
         vj0Oe/lLLWzRdLxOQpydSF5WH32dYb/4YFveML/LM/KnqZkkbZkErEbUvcZcaGSZINMF
         +r4w==
X-Gm-Message-State: AOJu0YyuZEt9rmWdC+JE2wdypHHwnrn3SbjCv0z9/My3f19MsnV6ekO7
	lYpXJrWCP1SPlxxQb+de/GB9YqL1Lpk2liV1+tIfW8SiG7SfHjzO7PeR2n3Xtg==
X-Gm-Gg: Acq92OFuVE1PA+ltfxcVz2Wxeg8oLM/jr81Jw5VX+GU+mTF/lTF5yQLHZsnXSGi69Te
	G0YNY9rOHYlwasc1aAlhU6TlPm68qTKmpC0rAc3qXKbwpf2cSCWwt+HX8Ds3YhvkB+f1vstFJ+E
	nXXSQAmdAems5aGzqijKG/fdhmei6SHTJpwzd9RCBu4QKHgTT1bRdHaX2ukKGtaac/mtE1MmQjv
	RBAdm0Y/P4KkIjjqeXVcfOyKSgJguJnnLOgFDB3WcWrEbey9N8DYj1B7OicJsHmE3Nu9tL/nJR5
	BRmuyLDAAWJBVbfKYUo6oii3u8I8BWHV9XfzVFzYOfinHGsDakZcdJrnX5U1hvBqU/56iRUIIRy
	Z4SuSCmjgAKItITrMBJJKs7N/mGRqOK/jlkZ5cHPDagYvfntqh2FmPR/WUgWhMyeKKHl2V0doFP
	UbOMnH60sn+jb/ZRswFvPmkD8Flw==
X-Received: by 2002:a05:6000:1862:b0:45e:edcc:f6dc with SMTP id ffacd0b85a97d-4606746a03fmr3334435f8f.6.1781170650676;
        Thu, 11 Jun 2026 02:37:30 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm85188717f8f.6.2026.06.11.02.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:37:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 11 Jun 2026 11:37:28 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 3/6] libbpf: Add path_fd to struct
 bpf_link_create_opts
Message-ID: <aiqB2PK0ZzuJNIG9@krava>
References: <20260610143627.804790-4-jolsa@kernel.org>
 <20260610145019.7F4791F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610145019.7F4791F00893@smtp.kernel.org>

On Wed, Jun 10, 2026 at 02:50:18PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Compilation fails due to missing `path_fd` in the `uprobe_multi` UAPI struct.
> --
> 
> commit c73ec6f8d6c5a6bb4c8a75f70c333cac0d6d30d4
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> libbpf: Add path_fd to struct bpf_link_create_opts
> 
> This commit adds the path_fd field to struct bpf_link_create_opts for
> uprobe_multi. It passes this new field through the kernel attribute interface.
> 
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index f37e3416f61a5..96819c082c772 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -842,6 +842,7 @@ int bpf_link_create(int prog_fd, int target_fd,
> >  		attr.link_create.uprobe_multi.ref_ctr_offsets = ptr_to_u64(OPTS_GET(opts, uprobe_multi.ref_ctr_offsets, 0));
> >  		attr.link_create.uprobe_multi.cookies = ptr_to_u64(OPTS_GET(opts, uprobe_multi.cookies, 0));
> >  		attr.link_create.uprobe_multi.pid = OPTS_GET(opts, uprobe_multi.pid, 0);
> > +		attr.link_create.uprobe_multi.path_fd = OPTS_GET(opts, uprobe_multi.path_fd, 0);
> 
> [Severity: Low]
> Will this assignment cause a build failure?
> 
> Looking at the UAPI header in tools/include/uapi/linux/bpf.h, the
> uprobe_multi struct inside union bpf_attr doesn't appear to have a path_fd
> member:

compiles fine, path_fd was added in previous patch

jirka


> 
> 	struct {
> 		__aligned_u64	path;
> 		__aligned_u64	offsets;
> 		__aligned_u64	ref_ctr_offsets;
> 		__aligned_u64	cookies;
> 		__u32		cnt;
> 		__u32		flags;
> 		__u32		pid;
> 	} uprobe_multi;
> 
> Should the path_fd member be added to the UAPI bpf_attr union as well?
> 
> >  		if (!OPTS_ZEROED(opts, uprobe_multi))
> >  			return libbpf_err(-EINVAL);
> >  		break;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260610143627.804790-4-jolsa@kernel.org?part=1
