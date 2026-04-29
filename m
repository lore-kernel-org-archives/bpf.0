Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45EC13B7AE
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496200; cv=none; b=QeE2MRQcCh7JDcStq1dGAaemE8s/d0gmc9KLZuIAgEFDhU5aOKDaMKDyh4e6z5SFYT74jPqIHj3e0nCWDZUapcTtE2xDWi92hhXFIB81+OubO9HKlYVaDDiylgmOuw0nmzGp6kgox1eS2CjrMXxu90zzlNN48xIkEZVI541xHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496200; c=relaxed/simple;
	bh=KcM6bkgoovknVoO7DyH8RZjp7sIX9YJ7+Gg8p+SHoPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGIpP3PWe5A0I5yFLD36W0r2kB84sNKuwdNzegUORVD0p+sjZR09vB2PweqTPEpxhG6mgU7U4vaF/zS7Zsf8dRTtzMMswspj3i46nHTieqJMGhj5/5OiD9YwsqYduKi0+pHwPkm+8oS1g3CHt3CGzg9WZTTt99JLltGX/0l+Y28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o7ri0tpI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7ri0tpI"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ba922426c5cso27681766b.3
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 13:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777496197; x=1778100997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb9L8WftaoHrfrq4miMFqQPjpoEXQCa3yqkZ/uqlKz0=;
        b=o7ri0tpIxidoqyCZodGZdwHDV05ZqwchcenKXVoZ3C5KMYLzXZpuAtK+KsALM/VFLL
         7f/hPeSokPE4n0/ciMl7XYdpNWZHqjFev35z/QgSDuW8arSt67hT++VoKYBcxWs67Okk
         0hucZSGyuMKfXxbptbDM8a1ShMGaYyjdU1c//vpfUf+5q/X3EVZseLa4JToW3fjnCda2
         s0nBSUSZA4dosJ/C1OrHd1eDjkJqDzxnrWO1nlx00TSlLQwpYPyyH2fRVD0OSs5GPe4C
         whYlgzA0i0tagfGZkzSrlyUq/+HbwDlg3L95+pLSk8VxjbYxP+D805jeH7tv078/Su/k
         xkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777496197; x=1778100997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vb9L8WftaoHrfrq4miMFqQPjpoEXQCa3yqkZ/uqlKz0=;
        b=ilDwYzH52XBFtjwVpn7nLX/m9RlpYRQ1ygzXdLicCXT/5yIRMIUueaOZ4Neyfew7r2
         jQUZpjJxsfvx0KBkCxONou39kklzgru3QwWlrH7f8qwQttXLdg1jUo/VgoEW5oHgGL4X
         osm4iwbEWWiiD8PUXmyCVcMOqFrRccLhZP2Yh+shMZBLHWSBYgGjjEn70L/JVWJaPzIC
         /rpyDDIRUdNQFEsXjk26KFVYABkztu2RtUpUxOubiloBidpfYpEGbtFLH2x7OJ4tGY/r
         ngupfAnQ4K3dHGQq/KPP/PioqKrhKvwR/dW0x7kS6aX5ght1AQfzSitFTTNQTgNSLhKw
         uvwQ==
X-Forwarded-Encrypted: i=1; AFNElJ99nkYM0zx4WJKcnpVDgvgB6HNr4LGQMMJfakUl8AFZoIZPnnF37tfpH/e6RK4k1cQ68WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSbc2cBgpFZiKWVUeHxG5InzGdd6FHVH+UuonGEgMl7DahkvVR
	QRa5fm5+MJbrtJNA8g4gDl6I1576ElL6MLURXaLQMaVcAxq9Gx5hipXmNV3fYuK5SA==
X-Gm-Gg: AeBDieuxr9Gm64Zt2qfz5fBKPUfSa3em904Fm0u0ikdRLMiTZEE7jsQexpAbUulhsBp
	pn6uU0lJogr7Qq79wfth9lfI6z2qHlYxBEoyTtsiuKV4mjUEIYl2m8A8jxjhTt5eN6aga3WMJRd
	HdmW3uAKbgZAh22vY9d8OLlWOLCrif44QMw5WPD02N++ocUG7F10DFA3Vfe9HSFXlZRZr0UQvLg
	9SoaqDvBrPx3Y46g2EOZNBLouGJpLi2INozfZd5NygFd+UqEvYplyb4nS/xXkL1pb+6W1yYSaTG
	8cvVUlEHBdLtJomWBpTEQCIZbYu1zbB+VLqu5VB5qMsKFp4xJ6ciOsXQkhlN1N8oHB2O1zwgC+G
	gQiBnremHs4YxprXuL82RiF9Did2gHW0YXM1g46ldWUhnnP/cLsEMGb8aH31U8BFt4gPZJAGPLB
	mS9wXpydNbK2EfD1/R58Cn5Z+/EKzBjxqKbAZ7fyKrjm3N6LJiTIWF037YdFofboHlK6OYayjFG
	Rz5ASZugn3Z
X-Received: by 2002:a17:906:eec7:b0:ba7:8dd9:cede with SMTP id a640c23a62f3a-bbac4bd280bmr18426666b.13.1777496196643;
        Wed, 29 Apr 2026 13:56:36 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb980a6f9d6sm140892666b.10.2026.04.29.13.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 13:56:36 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:56:32 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Quan Sun <2022090917019@std.uestc.edu.cn>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Null-Pointer Dereference in bpf_remove_dentry_xattr via Negative
 Dentry
Message-ID: <afJwgCvB3oV1wWCV@google.com>
References: <1587cbf4-1293-4e25-ad24-c970836a1686@std.uestc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587cbf4-1293-4e25-ad24-c970836a1686@std.uestc.edu.cn>

On Wed, Apr 29, 2026 at 04:59:01PM +0800, Quan Sun wrote:
> I found a Null-Pointer Dereference vulnerability in the Linux kernel BPF
> subsystem. The issue is triggered when a sleepable `BPF_PROG_TYPE_LSM`
> program is attached to the `bpf_lsm_inode_create` hook and invokes the BPF
> kfunc `bpf_remove_dentry_xattr` (or `bpf_set_dentry_xattr`) using a negative
> dentry. This causes the kernel to dereference a NULL inode pointer during
> lock acquisition, resulting in an immediate kernel panic.
> 
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> 
> ## Root Cause
> 
> This vulnerability is caused by a missing NULL check in the BPF filesystem
> kfuncs for extended attributes (`bpf_set_dentry_xattr` and
> `bpf_remove_dentry_xattr`).
> 
> 1. A sleepable BPF LSM program is loaded and attached to the `inode_create`
> LSM hook (`bpf_lsm_inode_create`).
> 2. When a user attempts to create a new file (e.g., via `open(...,
> O_CREAT)`), the VFS layer allocates a negative dentry (a dentry that
> represents a path but does not yet have an associated inode) and passes it
> to the `security_inode_create` hook.
> 3. The BPF LSM program is invoked and receives this negative dentry as part
> of its context (`ctx->dentry`).
> 4. The BPF program passes this dentry directly to the
> `bpf_remove_dentry_xattr` kfunc.
> 5. Inside the kfunc, the kernel calls `d_inode(dentry)` to retrieve the
> associated inode. Since the dentry is negative, this returns `NULL`.
> 6. The kfunc blindly calls `inode_lock(inode)` on the retrieved inode
> without verifying if it is valid.
> 7. Attempting to lock a NULL pointer causes a null-pointer dereference,
> leading to a kernel panic.

Sent through a fix here:
- https://lore.kernel.org/bpf/20260429205438.2601592-1-mattbobrowski@google.com/T/#u

Thanks for the report.
