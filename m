Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C292874F8
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986919; cv=none; b=skpoamGL+kaUmW5Il7VlKmAdk+QCXpvoGJMdehVKIeRyZ0yKG90oMxzEJ6PDKA4ZXP/67hOAm3smZIKxAPgEPSlwigqLX1KGRhCNa8DPvuKswLqRqCjYlYU5Oxaqf/apxBsgy9ZyBX/eUjZkrZ+Dx45twksimjEJD4aL2fYlvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986919; c=relaxed/simple;
	bh=3KsyrKI8a8WuOUPKHlBrtGyhseDhoopScvHffu8IHUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTUMlWz3HLQrBNNjFO7kXMG8enK8kks4PXuIAsmYjN0yXJRlRcRryUuGK1/eSLP0d6g7m8zRpMYECkr591eI0j4VmaCOpfL1802VBvOu6++rij5gRh7Oofp5eWfvFEp93fR/4zvI9b5+ohk19q7xY2ZlV+OemXbnByntR3QJg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TKrWrN5Y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TKrWrN5Y"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso46542095e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771986917; x=1772591717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BZGXshXHvJclcEjfMwGDZc/q9vZTX8b4lXQsjlQbCew=;
        b=TKrWrN5YNtYPsF5PHq2uYQ/UnRKcyCqlrTS6ECQmnNPFwL/ekxFEH0MATp0F0N6hDo
         aW5iou+mmYswDSBixQ6Yi5cPNWq7DxSSNXZqABJFDIIkzLKHvsV+fyZ20M5sWgj+jjCC
         ptQuXNmCJWsg2qu6y4gW3SOILyXBP9Uokih2pWVdxE2ImzMJiBEVMrEbYCRqLCs3XJiX
         xX/FANsOu+j9ZOrWdUkKZoyDzLM9pKJYEtmU8hQMO6LaSE2s3piBGHyWrbEm9/u9DbQ5
         up8OV9T3CCiSmdR35GdOPfSr7Yijaf2iIeQCmFYxpbtyCcfQzNhyUBEcjFAk588bo0nG
         6i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771986917; x=1772591717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZGXshXHvJclcEjfMwGDZc/q9vZTX8b4lXQsjlQbCew=;
        b=DkkrczpZpwHrt39o8Z6RxFs/oD8IWyYPPKRVkeq4hti2pjMluMyA9niNyAOmeKW1GS
         CLavHLrQp7hmg4q0A3MtzfKX8d9Z6jjKrozWyUBvukRDK3zHCi0aXUwq4H7Dm1zFi3+T
         TwkYUe/9W+AYv46be2J6f7uaVyQvN59LLh8P5JtAsQA+0UyiVjA0S+1kM/WjHB4JP12L
         ENxoMn/wOKLl+q5QPEGifNGzB6NYsuUje94ZPVvacODLd35HnMrYjPbN46gZV4wRIDpF
         1yFwXNOE5cyJXAqtZzVEyBbQlDqD4/j296Ani+0qVqEoWX/ZPG/uRFlhx4r34TUBzH+f
         2Wzw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ERe85Sjw/dkodJYeg3VTlOBO/VBPXLDoemhCWJZMb6w/IvaCMc4pF3jdmc2utwyEv8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfdzqiqeRCE5Rcw1BPA6GB81cYFUpwC9RaPrzkqqKgzYJLaVMu
	Qcm1r9X8nBlmd9sPobXjFWPUX9U5eWMPpTjdSWetlX9vdKFh6nzghkyttCvrK9fnt20=
X-Gm-Gg: ATEYQzzh7BT+GrbUpz1XP5FiDg6vtHcD8ioCIsLk2FCzXSWL7h6K7SYhPgxZebTdlZE
	kXSyiolEihkIi8YlPNIAJjn4Fo6XYU0pmEbcIz4FWi5H4ctMVnedHUYvTPRQ+EueQRrH7NtAN5h
	nUlJ6ljzdPsO8+gLNu/8j9nZxULYLlPjRbnhaZuzA7nrhHaxwqoyT1nwWVFuLXVmkrL7VzS3Iqn
	m2dIt8D8TOYXc+SclxhucN1x99oazdEFKZBDr1DTYpWDaSiSgyMAiAtbzK5K8kWVsSszSsdKM+O
	Hzci2NC5hJt0eloQ4Gs30oqLmkMMnuNh2WO6Xc3fX81VhSLO+/HZKm2pjGqKdUZvDIErioJxVvW
	m+wIPeVK+z1I7d2huOTfSLpX4CzlCPXFsqrEEFIBc/nAcdTmHXRsBR+jjqTClEAHWpl0zx0uXjG
	uH5uuivzCDZ6WQqBlapr8=
X-Received: by 2002:a05:600c:4f95:b0:483:8e43:6def with SMTP id 5b1f17b1804b1-483a95e5a97mr217123395e9.28.1771986916668;
        Tue, 24 Feb 2026 18:35:16 -0800 (PST)
Received: from u94a ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7244dadsm12268836a12.20.2026.02.24.18.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:35:16 -0800 (PST)
Date: Wed, 25 Feb 2026 10:35:06 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>, 
	stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: Latest BPF selftests on stable kernels (was 'Re: [PATCH stable 6.12
 0/5] Backport selftest for "bpf: Check skb->transport_header is set in
 bpf_skb_check_mtu"')
Message-ID: <crki45lsdj4yjmz3ix4k5scjuovjr56oexmwhhwbqeejdxh3j2@kgve6uooitce>
References: <20260224073810.85945-1-shung-hsi.yu@suse.com>
 <bd0277b7-4a19-46a4-9f06-96d48cbc89d8@oracle.com>
 <DGN6PFT94YHU.3S3UXTP82975E@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DGN6PFT94YHU.3S3UXTP82975E@suse.com>

Cc BPF mailing list and maintainers. Plus other in the referenced
thread.

Hi Harshit,

On Tue, Feb 24, 2026 at 09:18:04AM -0300, Ricardo B. Marlière wrote:
> On Tue Feb 24, 2026 at 4:53 AM -03, Harshit Mogalapalli wrote:
> > On 24/02/26 13:08, Shung-Hsi Yu wrote:
> >> This patchset backport the corresponding BPF selftests for commit
> >> d946f3c98328 ("bpf: Check skb->transport_header is set in
> >> bpf_skb_check_mtu"), which has already been included since 6.12.63.
> >> 
> >> The BPF selftest added in commit 6cc73f35406c ("selftests/bpf: Test
> >> bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
> >> additionally depends on network namespace support for BPF selftests
> >> added by Bastien, otherwise the MTU in root networking namespace will be
> >> set to 10, causing other BPF selftests to fail. Credit goes to Ricardo
> >> Marlière for figuring out the dependency.
> >
> > Note:
> > I have recently learnt that ideally we are supposed to run upstream 
> > latest kselftests on stable kernels as well. If a feature is not 
> > supported the kselftests are meant to be skipped.

Thanks you for the bringing this up! This was also mentioned by Daniel
(Borkmann), but my experience aligns with Ricardo's.

> That is not true for BPF, from my (limited) experience.

I do want running latest BPF selftests to work on stable thought, made
some half-hearted attempts last April on trying bpf-next's BPF selftests
(during 6.15 phase) run on stable/linux-6.14.y, but wasn't able to get
pass the building phase.

As far as I remember I ran into issue building bpf_testmod.ko (kernel
module) of bpf-next against 6.14, and other similar issues related data
structure or API changes. Pretty much the same set of problems we get
when trying to build any driver in the latest kernel against stable
kernels.

Maybe it can work if BPF selftests that does not depends on
bpf_testmod.ko, and build failures of BPF programs are simply ignored
(not sure how feasible that is, probably would make Makefile much
complicated), so for now I'm sticking with backporting BPF selftests to
stable kernels.

Thanks,
Shung-Hsi

> > https://lore.kernel.org/all/a45eaddb-9e17-4e82-8a78-a1d1f6e3d735@linuxfoundation.org/
> >
> > Thanks,
> > Harshit
[...]
