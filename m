Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013F83B4EBA
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168053; cv=none; b=E9KRuVLbEPPH32cyrjVDMtfELUiTsa+WrXKVK46wNi4DBvO5Clz4CSql4GbO7ebZWnIn/1SlSywj5wJxF4ynduMXaHmBUC9DpS2hhSI1NGXe/jtAYcymTnz9UQjVzGsC4j4hRGEcBMJ93HEGbVv6o1U+kciN8N+XI5sDVIK9eY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168053; c=relaxed/simple;
	bh=67BO0RZg8rxb/E50RmGcBJlsPR5Ae9xmCy+Q7v8QtDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQ7Y+BJ75kE3PUrLK2xmGE2VzDjgbwgry3ij+eqYEa9KovwoTwnDZS6V00J4xiNnk+QK3bDwVdMZ9GzYx4uV//LKFjHJ/0OGhpp6n7Eyg/NwpkISRq/+/0MY4+2kvAW8VTR8kxPtgTZCM4t/AvVyoUe4cKqvg2vmD053hVE1IuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH0xiiWz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH0xiiWz"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso44031885ad.3
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773168050; x=1773772850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
        b=kH0xiiWz4KeHg8qM+UQYFRGEoaB5YhGQ1/l342lI48vVjCWqHFWSBUDJtSv8g6YdEb
         WUvbLXs80bxV+xnMTu2IxnxqQ1WawTtw06PwWKuvZNeHk5D3euuYdO1/s0++E4FpGP2z
         +c3ttwFV6WwPOQpNHM7WUIHZNaqG5koiMMCxTax1rBk+j7pB0850FJbGseMzgmcav/Sc
         D4sAVnEuBVkUt07E/ANMW8DM/NJ+n/hx2N6JUcXYsLZYrFMsnwCK7vKttbH8x8ketzgA
         AEJgLDRmf5idGKEt1ix0VwO4x51qzzz9/bjh5SLZJM6RE+ISqePxLY2ZYvsw4O/i3F73
         NyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773168050; x=1773772850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
        b=NIZDEuqiqnx3hQFDTYjkeuHdU+absY4DSIMlWHkZi17jxwTwU2jFjVS6NL+6euxwlZ
         pBVl+9NF2fVyV+GDtlShS4GCD6gqcSvZGaN6SH3XQ8ZKsqRXRQi0KRG22v1Iy+yvfNKX
         iD9rcmsjMuHVnG55jojehMKbLGwRFwsq+jfYIjiduiNgdcHvKRN8+dDxyn5MgH6XFIAy
         mULFKv2Bm3LmDyZXCBCgzbVKpOYbW8bTUogQ/9kab/gl05ae4Fl4gDKEuLQk5mxM6Um/
         /CWVc8rvwUDaBHbz4Ow2EJGEsWXA2hcVMB9QdsQpcNroTJi1SJdqXVfd0GAyedSpIH6v
         LS+w==
X-Forwarded-Encrypted: i=1; AJvYcCV9UBadFcbZEgg1A7f02IgTD1nBq1b2JIKQHgCAN8OZ3h91iaHp7kiwCWL5UN5ig4PEA2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAeZF4srz1iZvofYEzgaQEyvCqOqQHsxJYj2L+Aa1nzswzRIsB
	ADzF3UVKsrUrpDyuT/89qgZ/iysFm1oEzdrpjNwaMOLuZM00w2i8bkxw
X-Gm-Gg: ATEYQzx6lkWcPTn7XRLuMSf5shSq3bc7uvKFHxrpuv7/MBLQ3lwEMmMmL+0WgUnRM3R
	3ai+dS0KUDg+OdTFGXStldl0gsKafPNRGlyQYwI722pYrF7WIk0R/jdTB30wa3VSVM5jjg9n4b8
	BMNnVnN50pTB23IrKiUvf00SmmxJ7uu1Vod//CIlgnaWdMDVKrjq31WXaJDLZxyjXhhbjNtkEWK
	LNeKgu/2iK2YSe8bLyuEqhUuJ5FVLhCD5rp7V4VfPOn4jGb13g7p7Xbm+zvdr1Br8HLN5F0l73m
	zwr2V47aMBAI1J7dtIet0sTR3yGIiUybVDnqCV0+ZWZ/yNZbq4Pz3FrRMhalfVgoU520yCgKDx0
	3auRCcqrRW0SYUk41CeizXCfJDWEkhE0Mh7eP6gvw3uc+ioF2m5Ge29tbTzenpoA2Q+GtPiKmkH
	eL+kpH6xTCeMdwDKl5BydkLJG7EAqhKt8BV6M8sdPpDd0l9Q==
X-Received: by 2002:a17:903:28c8:b0:2ae:5671:7071 with SMTP id d9443c01a7336-2ae8252cf0fmr96662285ad.43.1773168050081;
        Tue, 10 Mar 2026 11:40:50 -0700 (PDT)
Received: from google.com ([2402:7500:a44:85b:2953:97d3:b283:95c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e58592sm220535625ad.14.2026.03.10.11.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:40:49 -0700 (PDT)
Date: Wed, 11 Mar 2026 02:40:36 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <abBlpGKO842B3yl9@google.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>

Hi Philipp,

On Tue, Mar 10, 2026 at 12:48:26PM +0100, Philipp Hahn wrote:
> While doing some static code analysis I stumbled over a common pattern,
> where IS_ERR() is combined with a NULL check. For that there is
> IS_ERR_OR_NULL().
> 
> I've written a Coccinelle patch to find and patch those instances.
> The patches follow grouped by subsystem.
> 
> Patches 55-58 may be dropped as they have a (minor?) semantic change:
> They use WARN_ON() or WARN_ON_ONCE(), but only in the IS_ERR() path, not
> for the NULL check. Iff it is okay to print the warning also for NULL,
> then the patches can be applied.
> 
> While generating the patch set `checkpatch` complained about mixing
> [un]likely() with IS_ERR_OR_NULL(), which already uses likely()
> internally. I found and fixed several locations, where that combination
> has been used.

Thanks for the patchset. However, I think we need a explanation for why
switching to IS_ERR_OR_NULL() is an improvement over the existing code.

IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
flawed API design. It usually implies that the caller is unsure whether
a failure results in an error pointer or a NULL pointer. Rather than
doing a treewide conversion of this pattern, I believe it would be much
more meaningful to review these instances case-by-case and fix the
underlying APIs or caller logic instead.

Additionally, a treewide refactoring like this has the practical
drawback of creating unnecessary merge conflicts when backporting to
stable trees.

Regards,
Kuan-Wei
