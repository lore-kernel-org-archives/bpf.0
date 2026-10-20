Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518465;
	b=NqxHCszSmEYiW+AMSIL6sGGL+7ogHYnxtNo2sGWp7iLhVgYcYAPd5JTAk81+rXz/+kdB
	 2ZE/CsUxBJ36OmVg2zJGfig+dwBvOkpYHFkHre+ufSWGAp9FyRQDV64lHlXBKrmsSjpqN
	 U0WOmhK0pyrUnYw6laFmsICxSK1m7TWv6gQSP+4m6u6rrKdUlsoka1DXT8E1yp21468hX
	 brshs2mZyfl2B6gj2O+VMciPp5R6oO3q2IZ2ksmV9wj7ewllXXxYfvR7niRHOC4c5fLCw
	 rx+onuNACmsF13xzAlft+kFtYMH+2nOYVDyE/zem/30X0wzGR9zPEEMIMY7wdUvytsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518465;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=WgFMIOh93QhT86nsv4SkYxtkJuNYyAnLVgqCXTRDBJQ=;
	b=keSMwHkcUWLA4GEI++mYS62L+ujzxjoklox6bwbF0KspUAVaxV1Cxg7Vr4jyOkCdVWvz
	 ase3ffdxQkuNmiWH1BonhL8/UY37cTeVj4ozbIEerZgwYNvevEEdZiyz8oYlFJaX2Fm+6
	 T4wuWNOmcjLiFmyOLtAsjC9t3rOj8OZL2ASSriu5Ue38NfH/cDExNcScB9fvelg1yqyJk
	 nJtpdUg6RQ7Afyxh5o/I5GzZ5lH1xGCCu/0r6w3MZkgQIyW04JLgjvvyH+rqvG3VfFFvK
	 JQlQUlcCkhZMnqXr6xVGc57j+fraL8fUlnnk+RRXFE5KEbMWNs/g90hz8VQ/WnBi55g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dq9Yd4X8;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0C606A334
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F0C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dq9Yd4X8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792518463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgFMIOh93QhT86nsv4SkYxtkJuNYyAnLVgqCXTRDBJQ=;
	b=Dq9Yd4X8PESnjHbots3HCp5ZiyfNXnyO9BjlheTFyZHByNGRXtvmCljSJi3THZxsHjjih4
	Fg8s+gKfl4D7ZHpdiydjQCo0JqHhVviNVFaXWgFBF/MfWdzRndiHlWl68YAbD9BP/XBUev
	/AoZYooZx/VpVBPa6+PSW5CMBbvhXtU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-ottbI5POOUSdDjVlOIXqxw-1; Tue,
 20 Oct 2026 17:47:36 +0000
X-MC-Unique: ottbI5POOUSdDjVlOIXqxw-1
X-Mimecast-MFC-AGG-ID: ottbI5POOUSdDjVlOIXqxw_1792518453
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89C1F18005B3;
	Tue, 20 Oct 2026 17:47:31 +0000 (UTC)
Received: from rotkaeppchen (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F5FF30001A2;
	Tue, 20 Oct 2026 17:47:22 +0000 (UTC)
Date: Tue, 20 Oct 2026 19:47:19 +0200
From: Philipp Rudo <prudo@redhat.com>
To: "Ard Biesheuvel" <ardb@kernel.org>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, Pingfan Liu <atlarge80@qq.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jeremy Linton" <jeremy.linton@arm.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon"
 <will@kernel.org>, "Simon Horman" <horms@kernel.org>, "Gerd Hoffmann"
 <kraxel@redhat.com>, "Vitaly Kuznetsov" <vkuznets@redhat.com>, "Viktor
 Malik" <vmalik@redhat.com>, "Jan Hendrik Farr" <kernel@jfarr.cc>, Baoquan
 He <baoquan.he@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 kexec@lists.infradead.org, bpf@vger.kernel.org,
 systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dave
 Young <ruirui.yang@linux.dev>
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
Message-ID: <20261020194719.4fbd4e4a@rotkaeppchen>
In-Reply-To: <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
References: <20260322014402.8815-1-piliu@redhat.com>
 <20261011201325.GA918242@nvidia.com>
 <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
Organization: Red Hat inc.
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Jason,
Hi Ard,

let me add my 2 ct as well.

On Tue, 13 Oct 2026 21:19:28 +0200
"Ard Biesheuvel" <ardb@kernel.org> wrote:

> Hi Jason,
> 
> Thanks for chiming in.
> 
> On Sun, 11 Oct 2026, at 22:13, Jason Gunthorpe wrote:
> > On Sun, Mar 22, 2026 at 09:43:49AM +0800, Pingfan Liu wrote:  
> >> *** The history ***
> >> 
> >> Nowadays, UEFI PE bootable images are becoming increasingly popular
> >> among distributions. Currently, we have several kinds of image format
> >> parsers in user space (kexec-tools). However, this approach breaks the
> >> integrity protection of the images. To address this integrity protection
> >> concern, several approaches have been proposed to resolve this issue,
> >> but none of them have been accepted upstream yet.
> >> 
> >> The summary of those approaches:
> >>   -1. UEFI service emulator for UEFI stub
> >>   -2. PE format parser in kernel
> >>   -3. Signing the arm64/boot/Image  
> >
> > I recently had an interesting discussion with Ard around DRTM for
> > kexec and we sort of independently concluded that #1 would be the best
> > (only?) option there.
> >
> > All the implementations of DRTM today live in the EFI stub and
> > intercept the boot process as it goes along. After ExitBootServices
> > the DRTM implementation will launch the kernel in a different way.
> > Even worse today's x86 version strongly requires EFI boot services to
> > connect the Linux stub with a trampoline helper provided earlier in
> > the boot chain.
> >
> > A kexec flow that only works on decompressed vmlinux, with no option
> > to run any EFI code, is going to be difficult to support. There is
> > enough information and choices involved in DRTM that it is undesirable
> > for the predecessor kernel to try and DRTM launch it on behalf of the
> > successor, let alone trying to get the insane x86 trampolines into a
> > kexec successor kernel.
> >
> > Given those constraints entering the successor kernel through the
> > normal EFI entry point is highly desirable. This would allow x86 to
> > continue to provide the DRTM trampolines through an EFI mechanism and
> > means the Linux EFI stub always handles the launch with identical code
> > in all scenarios.
> >  
> 
> With some help from my friend Claude, I've prepared a prototype that
> reuses my efiloader Rust crate to boot EFI stub images (bare Image,
> zboot, UKI) in the kernel: the EFI boot phase is invoked at kexec
> load time, and runs under the preceding kernel up until the point
> where ExitBootServices() is called. Then, the actual kexec call
> will return from ExitBootServices() after shutting down the first
> kernel.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efiloader-kexec

I only took a brief look and cannot claim to fully understand your
solution, yet. Nevertheless I'm pretty impressed. I also agree that
this approach is by far the best, if we can get it to work.

The reason why I and Pingfan abandoned this approach and went for eBPF
instead was due to security concerns. Our premise is/was that the EFI
stub must not be able to harm the running kernel. Be it intentional or
not. That's a guarantee eBPF with its verifier can give but a simple
file signature can't.

I believe the way Ard ties execution of the EFI stub to module
signature verification solves the "intentionally malicious" case. In
the end it doesn't make sense to try to prevent a malicious EFI stub to
be executed when an attacker could also load a malicious kernel module.

But that still leaves the "unintentional malicious" case. Meaning,
that someone tries to be "smart" and does weird stuff in the EFI stub
he knows it won't do any harm during cold boot, but that will cause
problems to the kernel running the efiloader. IIUC Ard's implementation
cannot catch such problems. But I expect it will be a total pain to
debug them. Especially when it is caused by some out-of-tree stub.

To be honest, I'm not sure how this could be solved. I'm not even sure
if it's worth trying. Nevertheless I believe it's worth having some sort
of tainted flag. At least that would give developers a hint that some
untrusted code was run without them spending ours of debugging.

Two more comments with my distro head on.

First, kdump is extremely important to us. So the final solution needs
to be able to load a crash kernel as well.

Second, implementing the efiloader in Rust is not ideal. This prevents
us to support the feature in older streams that don't support
Rust4Linux.

Anyway, thanks for bringing up the topic again. I'm looking forward to
see the next version.

Thanks
Philipp

> 
> There are some limitations (4k pages only, CONTIG_ALLOC support
> required) but it seems to work as expected.
> 
> I haven't looked at measured boot or DRTM specifics.
> 
> 

