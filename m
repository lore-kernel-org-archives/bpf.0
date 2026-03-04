Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB73988E5
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616642; cv=none; b=XB4kEyZZHlftFLx52BeSzP8nmKx6Pd5JMtztu9YLzTET6Y3DjZGCCRFmwUdoBjloVm1n3tMsO94t2M7C3u48slJGZdo2PNZiEnKSpUcTUxmsdVKonbsiH9fhlNCjGVQlujv72iIbT/IqxBRnRkEjMFM+6sV6l6BGiPkhgqGMyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616642; c=relaxed/simple;
	bh=qyvL/iXE6+TakoKVVxVCaopqm1BpX+f7Q05dx5gBHDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hd29anKsxZuWushZ9MjIhPrS5v/YSQAvKeGBKPKHZur9KGveU/Kg/L8QNtaRfHLuhbOQ5mR8uxy3wL9IV8ZBB8f9CU8XetAdRsnbBCKynQoCGnFYC4Jsqqa6UlP7NNi2gqYVQwPwS3HQoJGAPdkYwlJpSrfRRCdf4RFXZau/N7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9sIRKFF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9sIRKFF"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48371bb515eso99247705e9.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 01:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772616636; x=1773221436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUzQoESoh9/PqMSFbMpuw4Pmh5IPXiGP/qvOjxX4wwo=;
        b=b9sIRKFFaokgkSrgeWrbA/ViOpJjWP1ViLK9R1Hc1//m2coegBzgKtpFqwevCmiACZ
         C7afbaacWCHtjdaHICcRaatb9x6ZEJn6NhG6Zj9DIWESFWJ1Wfs22M1hBHSvsJT6ov0y
         u+gbatvToXFWw4Ws1z6B810aDtF2H+NtjWSzWUXjnH2Uagh4gEk5+S1nkLp8lVzxzopS
         A1lgIkzEEAlqX7ANlEMButL3162rmrsjjiFCTqL06qEr4gqfcdGAwI6S5Z1yvtqPS7rR
         QeMeyyLIZ4ZsiMHZmsjBPBW/Gjz82S/2K6mHxq88plnIdodtUPQPjzOSR2cd/SZiIcXY
         bgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616636; x=1773221436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BUzQoESoh9/PqMSFbMpuw4Pmh5IPXiGP/qvOjxX4wwo=;
        b=IrkPwGLuGRs476iX01NSe0hvDqCjAq7r3kHJPe/fCvmYIOeBZHadaIFwuk5SFJWNnY
         txelgRyu1lpNGrHPjMVDuV1VTsKQA9fDgvLeJ8JeDkx4nvpvmEFljWPqyiUPkTRATnMk
         5gU8MnavcNClQYmAVmLI2bE++iwU/XuKOpvOB/5jZCnp2zQ44XPOxWlhKyEvt/wgcYEv
         0yeAzQcq7M03fMVLratkz9PYABnN4FKQXwc9c37Z0pEPokQ+/yUYK0EBDZS7/Ay/aeEp
         N/z2TrYZoB79Y6DS+oqE34upHp1E4X6HAzGgxmCcXs7Zx1yn3lQuxPBnWrQmOtHzRzt4
         FDGA==
X-Forwarded-Encrypted: i=1; AJvYcCXnEojShQ/Utvy6cRPzk4NRbwOe0neHe5pCQo+6c/DwtzJEWOR59crAQBp7L5pRKvdJG7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Cf8bu1ZWdsqe903wLYV7CrWf0sR+U0TA0w2qPEEvTBpVeiv3
	y5ixdcEInjEFyJNl0vXknwW21iBlZa+Ym8tAylyttoYqxFAllzt+dXtO
X-Gm-Gg: ATEYQzwJiQKn9sG6kW+qXLfGwysrXKDc8E04gmIZVOnabKdOPAHg4xX1SNeFSDdlT4Y
	R5EIbVPP2ViON/lB90xRQ3UHtV8AASe3+OdRiXcBkU7fQlAM7/gXVT9pp6rxECzns3lF/Mo7mca
	GEfxmHM3bDMue7AQ3ItjJCoB/DB959HjzwN/Rg4Fle49PxF4DsqGl7kLCaQy60/15KRJzEiXQY8
	iRKnWsR2e5okPKJbsXhu7fm9rAJwArTxB6lKJr15H/QztrP9SMipiaXv3W9U+NdVzeZs3eYJXf7
	yFkufNlAXU28CFeMA4ESw7IxjHhjpmR9OapMtnl1j+9fmjYFn8lnTnftIS1u6bVYNtvhcSfU8hG
	pOfIV1KNPO+o2jbYtCWXZXYg8b/sWKs5282fujWzyX9MoTe5BUNeSVL5We9iI2vAo1JlwZX1XYX
	bwHSGu3QGwE2PsKgEbIlLwQrSyQhOItvAZrEWhy8eHgLHY+cuZmUS/cXTb2TbCC890
X-Received: by 2002:a05:600c:8b53:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-4851989024emr19550785e9.26.1772616636117;
        Wed, 04 Mar 2026 01:30:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851884225asm38972555e9.6.2026.03.04.01.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:30:35 -0800 (PST)
Date: Wed, 4 Mar 2026 09:30:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: NeilBrown <neilb@ownmail.net>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, fsverity@lists.linux.dev, linux-mm@kvack.org,
 netfs@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nilfs@vger.kernel.org, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, autofs@vger.kernel.org,
 ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
 ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org,
 linux-x25@vger.kernel.org, audit@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
 linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 000/110] vfs: change inode->i_ino from unsigned long
 to u64
Message-ID: <20260304092559.554ac9a9@pumpkin>
In-Reply-To: <177260561903.7472.14075475865748618717@noble.neil.brown.name>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
	<1787281.1772535332@warthog.procyon.org.uk>
	<1c28e34c7167acf4e20c3e201476504135aa44e8.camel@kernel.org>
	<177260561903.7472.14075475865748618717@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Mar 2026 17:26:59 +1100
NeilBrown <neilb@ownmail.net> wrote:

> On Tue, 03 Mar 2026, Jeff Layton wrote:
> > On Tue, 2026-03-03 at 10:55 +0000, David Howells wrote:  
> > > Jeff Layton <jlayton@kernel.org> wrote:
> > >   
> > > > This version splits the change up to be more bisectable. It first adds a
> > > > new kino_t typedef and a new "PRIino" macro to hold the width specifier
> > > > for format strings. The conversion is done, and then everything is
> > > > changed to remove the new macro and typedef.  
> > > 
> > > Why remove the typedef?  It might be better to keep it.
> > >   
> > 
> > Why? After this change, internel kernel inodes will be u64's -- full
> > stop. I don't see what the macro or typedef will buy us at that point.  
> 
> Implicit documentation?
> ktime_t is (now) always s64, but we still keep the typedef;
> 
> It would be cool if we could teach vsprintf to understand some new
> specifier to mean "kinode_t" or "ktime_t" etc.  But that would trigger
> gcc warnings.

A more interesting one would be something that made gcc re-write the
format with the correct 'length modifier' for the parameter.

That would save a lot of effort!

	David

> 
> NeilBrown
> 

