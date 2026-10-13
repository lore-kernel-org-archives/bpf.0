Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2821953F6BE
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919199; cv=none; b=MfnB3nxKjmFYEwspXHOD30MoKlE2OMaMtmoi1GGk0DFw7wDy6hY45LmjhsEotW6XQkbTGUV6bjClQkg9y+nT0OD0l1LUH+lQKCR0fy5zoZxqWtCxoLtqmj/n/tCjzUXFqeMTNzCBlnFZBhg2D4x0x28FHpldZ0vkgmlCnpTgPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919199; c=relaxed/simple;
	bh=KztZNu5qBs9cVEGD2TdiPH2fRcdnukaTCtn0HNeIciI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j5k1c+DEPvYRNF8IooTgrTUYeRdRYtollF+OHUMp8I+ubEqKGAsZ7cQEgkubo2AsP1GJxHdzWoJ3qpU1H0ld/gc0/RlRGhmWfTOgRsCT3Y+8JOlKCgIcvwK6gtyz82rSrlfKI1jX0HhckzLhX/3nUAb2QclErKQofONs3sViGQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMInvITB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMInvITB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6A41F00898;
	Tue, 13 Oct 2026 19:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791919196;
	bh=nBu/SOG7f+fTEFPghCxgukAfv2TSNxFqz02iS2imDx4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=dMInvITBUWu18BOgzkTbw/0Vdryo36Fo3yGZtzaxxx1y6/LofNQrSRPIXzC+q5iL6
	 wqTmd2oM7fkI1UAXregmggCMBzjZlm19Cf/g3falKdxWTTnds4ODojjaYvzZo05nOx
	 oe2KaNDf1fWqKLsBFFBZF18KgK2cGJuHCifjxJDqqZdLJzpz4AlzfcGxih1QlM/ZhC
	 XYB6n7JgezAbwTVLACvsnvFGHd2ESLhOFwy5t5l6UyBUa3IHB1dtWyUOyMz0GsH9xx
	 64/amq+7WHP/w70T6DMXAiPbxCb4Y8YtnF+JRxHoLAps8s8ZYcUpOJqIEhyonp8njN
	 ylt1QWJK7w51A==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 78B61198003A;
	Tue, 13 Oct 2026 15:19:53 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Tue, 13 Oct 2026 15:19:53 -0400
X-ME-Sender: <xms:VITOaqKl52pZNHkpPo8vq2Ye6p9_qNQTQrwEclVqNOzPVLDi9QLwdg>
    <xme:VITOas_lV6zrn9ir2SIeCEGM-ZgWMH1b52xW0_7EwOi2tmCOucdSlq166n12z_HPt
    Cq8nevjQLAM1ABMHNgVf6hPZJMZ9gPXfItQZ5V2wTDE7wcsjT1H4l0U9Q>
X-ME-Proxy-Cause: dmFkZTFDzKl0ELp2oEHzVBwWRQODLbH3awXaTOQ8LNvi6ko20mCD786pZgzvu07nYUzJ+8
    2MHgaTFAqgjwYW6MeoO97VVBr1YqpZJC0eokGoU1j/I30oUO9e/iBPnXoTTIX16Z71AYI9
    c45wuloWTMqcMuAsXv/W4KQhXF4Fsa4UndNspcE+Jc0YqcA/sypMHrlsBtTlol4j/NW9SV
    SDH1qFiD2qjcuXK8U3nUQCMVzmcYb8R9+Psu2Ad0mJTucSzvhcI2lq3SsOvuiKtNhTJnMu
    QytgnVVJTIDecKvNcISUK5DwtblU9PldILdwS2i2PbqxwY2bpFIHAdtt3aT1nwLQMkMpog
    h1bdN5nODNlnXXY0opAlXgVuG1iItI1C/KrLcbi4McWhBek6qNp0shHQFpZc11x5q9aDhj
    I5BLAEu52WQgJ3ei/tFr0ucU16OFIGCdJgOfNPXMcv6ze3GibxBp3uKdWsKnQF2m/XPLNl
    u2d8vL6AVc3LoNG9JPk6dia/M1HmqhVtXcp9LFRKNXx1LnzCYbH4yHw989oJuzyBj+HdiE
    /fzYK36ZQC+Pc6h9LK8gJioUXDtJNudCvkqhS4tmSUsf2b4cBAD9WrkAPgiDTnTzDqSQjl
    vd+Y6bsgqWlgdQXIyhIDEW02CfQm0hmp0HPxOyhRWU0mvAWsy4gbJIkbgLdA
X-ME-Proxy: <xmx:WYTOatddi5Nc9SeJVUrYS8v9xImrZHI8z4U1EbbnLBG3OS9zPftceA>
    <xmx:WYTOasuHq0ZwguI9tduc6miqTLvnsLXtKbHTSpuqdgJ84yM7A_naHA>
    <xmx:WYTOarGSPLDt5EiyCXABcgisz3HNzuJSTA0jj03XKZGF4atlgHvihg>
    <xmx:WYTOamcls9KeR9mv_QJldCIxJ4hb-jHjyM195oAhGDRnCLe9hXMCSA>
    <xmx:WYTOanvOzC66MmWXMrTwOo692O0xbGrnEkvk_V_5pBjURKLRpg-PVy3h>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id BD601F80096; Tue, 13 Oct 2026 15:19:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 21:19:28 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>, "Pingfan Liu" <piliu@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "Jeremy Linton" <jeremy.linton@arm.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Simon Horman" <horms@kernel.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Vitaly Kuznetsov" <vkuznets@redhat.com>, "Philipp Rudo" <prudo@redhat.com>,
 "Viktor Malik" <vmalik@redhat.com>, "Jan Hendrik Farr" <kernel@jfarr.cc>,
 "Baoquan He" <bhe@redhat.com>, "Dave Young" <dyoung@redhat.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, kexec@lists.infradead.org,
 bpf@vger.kernel.org, systemd-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-Id: <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
In-Reply-To: <20261011201325.GA918242@nvidia.com>
References: <20260322014402.8815-1-piliu@redhat.com>
 <20261011201325.GA918242@nvidia.com>
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE format
 boot image
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Jason,

Thanks for chiming in.

On Sun, 11 Oct 2026, at 22:13, Jason Gunthorpe wrote:
> On Sun, Mar 22, 2026 at 09:43:49AM +0800, Pingfan Liu wrote:
>> *** The history ***
>> 
>> Nowadays, UEFI PE bootable images are becoming increasingly popular
>> among distributions. Currently, we have several kinds of image format
>> parsers in user space (kexec-tools). However, this approach breaks the
>> integrity protection of the images. To address this integrity protection
>> concern, several approaches have been proposed to resolve this issue,
>> but none of them have been accepted upstream yet.
>> 
>> The summary of those approaches:
>>   -1. UEFI service emulator for UEFI stub
>>   -2. PE format parser in kernel
>>   -3. Signing the arm64/boot/Image
>
> I recently had an interesting discussion with Ard around DRTM for
> kexec and we sort of independently concluded that #1 would be the best
> (only?) option there.
>
> All the implementations of DRTM today live in the EFI stub and
> intercept the boot process as it goes along. After ExitBootServices
> the DRTM implementation will launch the kernel in a different way.
> Even worse today's x86 version strongly requires EFI boot services to
> connect the Linux stub with a trampoline helper provided earlier in
> the boot chain.
>
> A kexec flow that only works on decompressed vmlinux, with no option
> to run any EFI code, is going to be difficult to support. There is
> enough information and choices involved in DRTM that it is undesirable
> for the predecessor kernel to try and DRTM launch it on behalf of the
> successor, let alone trying to get the insane x86 trampolines into a
> kexec successor kernel.
>
> Given those constraints entering the successor kernel through the
> normal EFI entry point is highly desirable. This would allow x86 to
> continue to provide the DRTM trampolines through an EFI mechanism and
> means the Linux EFI stub always handles the launch with identical code
> in all scenarios.
>

With some help from my friend Claude, I've prepared a prototype that
reuses my efiloader Rust crate to boot EFI stub images (bare Image,
zboot, UKI) in the kernel: the EFI boot phase is invoked at kexec
load time, and runs under the preceding kernel up until the point
where ExitBootServices() is called. Then, the actual kexec call
will return from ExitBootServices() after shutting down the first
kernel.

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efiloader-kexec

There are some limitations (4k pages only, CONTIG_ALLOC support
required) but it seems to work as expected.

I haven't looked at measured boot or DRTM specifics.


