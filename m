Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392A45A288
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437427; cv=pass; b=lr/KViKyrWH3MOconqve2lqdzTWhpAwKFK+nEzJaIRd+8Ey0wex5ir7fV1lVlruZEsEX8XampQ9yRgolSpKRgf9SR54txq1d0Z1uC4BOSEnux/n+ZYCcE4KtdzzpZ1BvkSamTbluLpdVTv4RW2QXAh2Xody4+HY3V6gWtvQ8qBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437427; c=relaxed/simple;
	bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMKkjmn74GX1CcHPuTiFx74ayd9Ccw2mixkqT/Z/O0uXoU63au5BbdN5j/c2XVCT3OH5mxWnpoDT+P7alR1COHEEiSA/PEIH+4D/TYrVwYoWvh0+SPKwrJzyKZGDvRvFHkT7Loo1SZfPEZguMEvCUJN4UokhdeEQ4MGCzRHpLoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8Ej7zYc; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Ej7zYc"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso169230fac.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 11:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785437425; cv=none;
        d=google.com; s=arc-20260327;
        b=bIzoNVkZJI5dYGNb48fHJnK3HKCZJKdfg2EOJNbr++roN4+caV0hDkkOAVjwJN0kjo
         mTN6hVSPCQ0qBz73f49uMYFe42/LmeOzbCiLCmYmbK5runHz5HLBP9VVy+Hw2ZC+QTTt
         T+9bqV0LYOeb0F+NI2uzMqXD5EYm5SKo8PglluYqCtu+GQE5LNKadFNHC4fFwzgQWX5h
         /OBWVHqd0v33SogLEjB2YlRf9iLOXO2IL1o7q1DqilbU0n3iU5zYr1yLMgWHK/Cou2D8
         7gbNfy1PEcsE7kBcSxjcpCogkuq6YbBppkdsAqme2pTIOBduZ0J77Dj7dcSozCvpdXL1
         Wp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
        fh=RuNLubCzUhjd6fSu1EH5LkqigPyZ61NiTGc2GlZs+a0=;
        b=HMHXkmCIM1/3KoapUSFhTSwWXoH5+JYvZS0nof1ZFZpE+QAcnHjY3JJURzlOjqzlf6
         qy3dDFi0SLwlKJNQ+IyBstf5RtodxqS8kGUY02tlkcLPqS0UXlAH95CFs4UABiW90Pua
         cAH6AeX1a9//ihjHqvap3ysFKV/x/isf7xHdQ6uOSJt7MeUAjI73KzOHFsLhTq0BWYwg
         RPSo5gOISMbH6wy+0lBggHYqTQishIuPAzdO9ycJdrAfiyiTshdMpo5G3ARagSie38xF
         DgxpCsN6dsFxFmOfpET8gdThrQpxuOMMSDEMzGmOoodfqYnKJOrcCSoHAKg1+IhDsWIe
         goaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785437425; x=1786042225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
        b=f8Ej7zYcREBo1Ix7zZLzyYMQJtQKmTw4vQxRTwvgZZ4l45bRzkXbQePryCxlA6Gpym
         usN/hO1GLpIZSxskRSKwpaR8otVXoEkHEd3JjzWhJL3aLkcfslWeD48SDFTXsi0PqLKN
         dhnwpfW4BT+GatS98gLfA+20Qdb3t0C5y0NDuNNK8ecekSSTGBi7r+BZol9czngbZhNW
         1ASfRJ8CxI4ptIlM4fLxkEwKq3qaEaT3qx1+FkZrY4QBhxQr06m33FACAdtcWh2LVMcO
         KAsDdfDivuX3+EnVudaXUvGbdN6y1GS41aw+5dGCImrGPpIx0wz3azmyE2bpaxUfXkie
         M4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785437425; x=1786042225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNy/bcDVAaOXHFeFKod/slRT1Pma9CINKHcuSvnIRJU=;
        b=WdABJdMRcf9tvAE34cxe8ucPXTth2rYlVVw1/ZJ7mxt93GoGrP7XkRPjHLuycTHWGo
         +HI16oRKkyXPsPbr5XjCHQgjmVqYVEzWFLImRby2WzGvjpqwiLrZ2doX27BL0TB8l8iu
         xCokME9DrFK9BvPlMFt/5veJkaO2RCaYj2R+I2ainij3cI/8tr0ejmfu2i/+G5eHXiAv
         9u7vZZM9t0EOfzZQAx3r1cmyfpOm6iIQxJiOyHsgPTG7Bn42hhUSYydXyy4+5Onj7N8I
         wmByJ/gKpp32rGLwNI8Puooj3083eVSQuI5J/7JSWDkJ+fNwqbpc618LMgwwUFkRdqFc
         F+AA==
X-Forwarded-Encrypted: i=1; AHgh+RpFk2gAWSkt1AC1Om0B+OUUlNUZ0m/PZ4yRp2MtS5n9O1wWFiT9763NfV+A/7shI3Nxmn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzR4zvPsN3CdFu+mEWEt7S5atE7doYk0TfDJIY44NNILUFeRT
	ZfvPwVWkn0foBKS851fv3CEhqvqStIuDS+Zg1eYT22lCXi2IrnoqEDSeMePDBAz0JpAby3SenLY
	jCthcJpFqBtwPKWNtqB0Z4UbRRvRE0pE=
X-Gm-Gg: AR+sD12fj6mSC3qySM3HWXm3hLnGT/UzyVuA+Bt5KBHhqyOxjhbGY04vFSTgFSgEF8e
	HzoDNYGWH5baj44NoIHb+bXMmQG6V93f6f67U87Ve0Mc2i9ObiIUR+o05IUSC4qQGUt99Wj/0xh
	ZdJv5kUCgsBkpXVPsajdliBWXFSnNiHgqC2uxlyqh5BwL6ZGYNykyvKDDvYFf6Ss1WQN3TN3hKt
	sLZe+z3RGcE8AAg3vZP8yDtZSmynYyhkBT5b3uYQkXT4sS/8Ev5dDY/sUgCUvlEBt+aEWn70GE+
	JkGWZ2xTWz84g+tpFIy4I/msFRI/oSjZBiDAe259ge9G
X-Received: by 2002:a05:6870:8a29:b0:456:b249:700c with SMTP id
 586e51a60fabf-458c0e1c200mr2600508fac.19.1785437424719; Thu, 30 Jul 2026
 11:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01421d53-c379-4044-9da3-5990186303ef@iogearbox.net> <20260730181008.3654413-1-cmllamas@google.com>
In-Reply-To: <20260730181008.3654413-1-cmllamas@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 14:50:13 -0400
X-Gm-Features: AUfX_mw-sWflnKZtGKmCqYRU0sb3jjE3qrtGy_CKaW2nfsOdhimFd1pr1NGG468
Message-ID: <CAEjxPJ47CTKXxx_DvSbuO5F28T-eNPnQQ+Gm_-qaAeb6R3wPfQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
To: Carlos Llamas <cmllamas@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 2:10=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
>
> Do the SBLABEL_MNT check before the inode security is initialized.
>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
