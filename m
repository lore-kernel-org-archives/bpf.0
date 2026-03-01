Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8425393E
	for <bpf@vger.kernel.org>; Sun,  1 Mar 2026 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772332353; cv=none; b=lFiXgOxsjGfr04z0WfSmKbA7ZoJr95mmdtEboU9qOxwnze4Hiee58MIDuZy1qFS6kozuGP66B0xBElaARnO5KIq3eRNpTSib50BVC1YBHyUTY+YJp29jBzvQuOty/lcaSRurI4tR1XZ4z7VKxOTFC5/zwjYKIJ1JwKD6i92UVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772332353; c=relaxed/simple;
	bh=5tHPwb2e/izTj3Q493jmeFKidyfj9OfoL6YRqGJfV6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy9hwyh9SkAwiYRXBno2vwWM6rbgOFoLuv7vvcVmYS92kfZIz32uirBKsCUIfBTtfSLDIb20cPOtW06fPJQuMzDq3W7yo2KEkY5cA6NJhPk+O+S8AfdFELFE3zl6bInHcMsvE6SOay2UWs2uMkWW2+LpG5+1MCr3uNk9bWAkt6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9ukLKBD; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9ukLKBD"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso3192518eec.1
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 18:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772332351; x=1772937151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFmASH9t3VnZs3JmetqH7z59S6tUzpkAkdGYc5lgV0o=;
        b=W9ukLKBDu6izz3XFVEmgT38hmAEk3V3DEvKmoWV1WcdgIDCjn9O3RLSPP/KU97+Bdv
         lSck5blOK8zflSIKyatyD9xaW7uGLvYH5utI7H6tyAygGZ7wCgI9uw/8+2laiY2M4ZyT
         QU7PbiyFeiKue2pROWZwLBvHSruAIs2E76PYv4Sy8RKENeU5+VuOh6RODl3SFSdLRxRH
         5tva7My4xRvjluqQ2AVrO30m8lw0TeDJ4BNb54MAzpuY17CJ2pscVxL4Nv7IUGrebKtR
         6o/0XNnEQktHCrx+haAGNRi7aM+zmvJGk5G2TPXXr5fkhWlzLrE1/eR5/vc1B9kGt+x5
         wXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772332351; x=1772937151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFmASH9t3VnZs3JmetqH7z59S6tUzpkAkdGYc5lgV0o=;
        b=J68hAc0qJQYfyt0TEUz1ZTe/Rmetzl31koOFjb5SDYRMy9InzuO03lo6+hA+WzmVgI
         WmS57y4XdKMgxnLZHTpVLF9bLeMxnDk5uDNqH1lozzSi/CWlHmgPPO5hJFb5RXwgR/Mp
         /V5zUTwYDKAYr5Hsq8G1ISXAfh6+EvA5jFKdSUoF8wHV3mgIGNH6WDkgd6dTDJL1/c+g
         D6NEhetxpWF4pMB0R/RGRPHT8bHWGRaZptwgGFzSSsE6uyXYmIcSibObI75DzRWTqR+d
         3hsdi9RvjjPUWN4hnqY91QkjDubbGl/oDT0NXGBvYWjKtsHp77mEMDgz/eRSmbm1H6Dn
         aWtw==
X-Forwarded-Encrypted: i=1; AJvYcCWZxRgKLVdgHnIFDuueINKkoEtk6Xdbn5a/XcBp8ymBYzjRv1x7Hd7x4gN2VuhhH/muY7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkHnXngt+R0wFJP0wCcqowkMvRoQOPN6V8QaenGdj7MaDX2eN
	6Szf3AkwJX/3pGVbaSpJjEQDoSy+fYs/Yi+6/U1XYeAppQbZMGXj9cKZ
X-Gm-Gg: ATEYQzwxhkn+f6bs+4EtN6XnmwKrNh0rw3yB+CMZVoL6IxPoiUMwYDeBLvCr2TR/6FI
	jorZX2rM9ajmxRn9B4iZeOq8Dtk421d+nk0wL60PyTDp5e6mVC54+SR0x77cvbqn6mA4CygOIze
	EN/xHtxCtjrrNfI/ZFiWbSIXeSi4Ck2Xz+24ubMKATO9HUse1FJNwrur8Gn+T9opqeHOFMS2j4J
	icwl5AwRl8enY7/kBL0jUhUpkDGTuXOEMfiFGO2rU/uX4h6JOm0PI92UXN5J6kHoodfvmzOQwhd
	wSzQjMCxLQ3aY2ay7rSmp9ex6iBqcBHN8JyR9ZqnjBpF+ZRuBUaj+GAoRRPygoelBTWzuT42wOo
	MPVqirxOPkldnkTUB7zwa0EnXlFCnPGra86h1SEKCDu+Udn5S26RnTIgbv6kO9L1sFeZ7zf2ps2
	V/iXyE+E0rvw5EA3grOJPIf1fFJbF5nA==
X-Received: by 2002:a05:7301:1f05:b0:2bd:f5af:62bc with SMTP id 5a478bee46e88-2bdf5af6e2cmr1357800eec.25.1772332351517;
        Sat, 28 Feb 2026 18:32:31 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:1e56:f0c4:e708:15be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1cefd7esm7589514eec.9.2026.02.28.18.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 18:32:30 -0800 (PST)
Date: Sat, 28 Feb 2026 18:32:29 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiao Ni <xni@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org,
	linux-block <linux-block@vger.kernel.org>, bpf@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [LSF/MM/BPF TOPIC] User space RAID5 with ublk and io_uring BPF
Message-ID: <aaOlPXCM/ecbrTj5@pop-os.localdomain>
References: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>

On Thu, Feb 19, 2026 at 01:38:46PM +0800, Xiao Ni wrote:
> Hi all
> 
> I'm doing some work on user-space RAID recently. I'd like to propose a
> topic for LSF/MM 2026 regarding the implementation of RAID5 in user
> space using ublk and io_uring bpf[1], particularly focusing on the
> challenges encountered and potential kernel improvements needed.
> 
> Ublk raid5 uses the ublk framework (tools/testing/selftests/ublk/),
> with the goal of leveraging io_uring's zero-copy capabilities and
> BPF[1] for performance optimization. The implementation includes:
> * RAID5 stripe handling with configurable chunk sizes
> * Multi-queue support via io_uring
> * Degraded mode for single disk failure tolerance
> * Integration with io_uring BPF struct_ops framework


This is very interesting.

Although technically different with RAID, how about user-space LVM?

I need it for the multikernel use case:
https://lpc.events/event/19/contributions/2074/attachments/1776/3957/Multikernel-LPC2025.pdf
(slide #19)

Relying on the in-kernel LVM is not ideal for provisioning since ublk is
already there.

Also, it does not need to be a complete replacement of existing LVM,
a simple ublk-defined storage isolation is sufficient.

Regards,
Cong Wang
