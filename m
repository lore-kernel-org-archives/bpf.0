Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794657338;
	b=U5EFT2MjrpFlAI3Aj/gVMJ6O59OZn6teQ/M54GgTasDxxnbql36U2lLnle7kJy/90Y/O
	 aZHGXA4eY//HQ85L/p/A/UO+XhDm7BGuzO8AtvP2Gbx/mvjdAVTWC/W/jr49elDwwflm2
	 ubBwGGEVlojAWM98NMpyOGGhPtgEYe1zuwWtkZy7lG7tQSekqHosEyp1QBPWL3vBU7BvN
	 AU8ynzNw9QoYxZi8D8XAkLkVcJ0Ynj6ssc/iGhpOgo1VCNtxAPIXqMWBo3S34qGdWGxx2
	 Upzck0hWs15ktPqNzwjqBjOOK7rWIG/CDWiLFI3wue8WjBz0y53KAjKFGYugnfSIccg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
	b=izWdRW79TWNPAqKMpqGTFQzTyrZPZ2Yk8pZCRG7MJdE3+oo6ws8zhfxJ54iTU+Jls2C0
	 UPPn+s38QCXJYFygG1u1ebSudWzOcdIx81SdNbagrfSTlqW8TW0b/zs9OK8EtZbQA4tot
	 Cmrqjy63XHSycaFIlaRtvvKfSkCdJw1r3Az/Cb7yG28kKv/18EFJsgpUAIBYUDj3WCou4
	 XCte2saJT0XRaLHWJTnALjHXMJyrYYCZqfYQc2/QfiHFcOoSANDwqayUzOioaZ9wU0xpV
	 XW1d5yABRJD0BOWAj5wSklNIKJlaAysaKa2U7NKBkFIiAXrzs4Jq8Lis6MFw8xHmrqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrTBjpIE;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B90606A333
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 11:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B90606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrTBjpIE
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50604721c8so370135366b.3
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794657337; x=1795262137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=MrTBjpIEXzsSZaANjc7oExJhwGnF+j3pBQoJGLV3AozjECewWnT/dOn8PoCfUIeYGI
         mRgldWBhVoyoY4kjpOu/TkcCPMpetn8bMN74Irqnk0JnK5MAQS777TE3iVfENO0qNvUE
         8qb82pxhdLikkA/6tATGUpByZMee1vHTbdl6A6vtosorr3+hE9wD/mpuH76lS1WAZqyn
         nUdTyabyG8UAyWqGnpYJGfY62DgpvBldD5kNADP5MARyaYxmHHJYDsQkr6qVKrnaldzF
         KHIyaxdpU8Pcl80WjVwUUXXw+yU81KD0D8RdN7wE6Dhf//BzElFXAKq/AgQBu3vGzFII
         7JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657337; x=1795262137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=ZKdGnbpNig2Rl4egaelhlK3nfkIcquttcSGg1LtB7zW6xCAgrCIolqOIKst4Fe+5DH
         1PnYmVb2IoQeSc5UR+VjqvdVrByPb3+DBctoBTRgjOZADCpNaNVqMizVQ0EK9mumt3zT
         /DweU53mJoitMqNmwbiTybbYyeG7VxeA/8B+Izx4qncPlyso4Oz7W3gicJoE2br+8jFt
         p18mR1WtYIp9iQjU/tE638Bk2698PeC/iAnGItIJLLzCuwxGta9nitDQh/ke+Lrtc5Lj
         VRhJfl8lB5VmDwPHeLfMqU3Iz71yuJZUkrqNcU9u2nYTP4h04PpduZ5uYa2c7uI//oQI
         sjJg==
X-Forwarded-Encrypted: i=1; AL+hErGKcABMAoockh2tdmSRFyCfvok2+LejBT2H9hqhoC0KrE2sIBbjBcoaJ8Vk42238B95Ui0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pWiAYjbNGIoYSP6ItHy1d+4Kusd6UUc4IpeRHUb7xts6tJOVZ
	oJc4aX7Ppc3zQR2s8XCaJQZGdNB8ZKSZkHb02tvxDM49d0oMRWUHDUMX
X-Gm-Gg: AYBFou0Ofk5Ln5rRf+Q1Cv/XatLVso8Vaikb2DUxphx9UhfsGXSNu2EqKs3RdS5v/N2
	F83NWHK0p7NIBwNZi5kZZ1o0DWEQ5d13TK8ATqd4XsAbOVqUsZSkeTnRnaXRqLyUg3/nKcyu5hs
	Qnqz32VPLjUa8IPORqqrJ2y3LTM/cuQ+rj5596GC8/gbLE0jinyIuAdSPchJiIP+Cjwi3Ij8nlq
	AHRPSWTkLgUuQlnA8LVHs7dLF8FHbZKhnUUEEvmmS7ySBXI5A14cmGW7SXiaeyysGRpUhPzh2es
	JmQJnOgHanDTXucHY7VmN78qDgFOENKwsI5KYeV+I1OwzjI9cwq03Ywqdlnu+Rj/aC4ne4qBz8U
	mgumgmb883yBhk/aLw3k5MFr2vCeworOZ8/c9F6S7F0psrXEHsjdeOLcakbADWnAEiFqtCx2Ykp
	8XvJDXKya6b7BjWsRIKVtnYqd9aOJEFGVCWvKg8TSLF1GHxbP3L7Vo+6aOxAQNBV6CdLXCx1d+8
	L/YyC/1oNbFJbQIP+7YxPY4rSt4MrWHl9Cfa2OieLE0e+RY9AoP3Z1oYp1EYhVoDFIhIwAeTJWk
	3/a6PwkSQfKnGXajQbiPdET3fceWwMA5Ebw9Re38TN5vFW8AaA9fPNCDGG/GDah3trhXHF1uPxz
	O/75pT2VmsZ8=
X-Received: by 2002:a17:907:3e10:b0:c40:231:6eab with SMTP id a640c23a62f3a-c5096370c31mr441592966b.16.1794657336589;
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b41f44sm206223866b.31.2026.11.14.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Date: Sat, 14 Nov 2026 12:55:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avhMN39TECaur0sS@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
 <20261111151202.GA11391@lst.de>
 <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>

On Fri, Nov 13, 2026 at 11:25:57AM +0100, Alexander Mikhalitsyn wrote:
> Hi Christoph,
> 
> On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> > I've seen setups where people use fuse to mediate access to sysfs
> > sysfs in odd ways.  No idea if that's still around, but if so, this
> > patch will break it.
> 
> 
> Oh, that's painful. Do they use backing files for that?
> It's a relatively new feature in FUSE...
> 

Very unlikely that they use FUSE passthrough and if they did
very unlikely that it would break their filesystem.

The API for fuse passthrough is that the server requests to setup a
backing file before open via ioctl and if ioctl fails (as this patch
does) then server falls back to non-passthrough open.

The ioctl can already fail for many reasons such as MAX_STACK_DEPTH on
procfs as the commit message says, so server needs to cope with the
fall back.

Thanks,
Amir.
