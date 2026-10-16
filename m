Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4A3E1204
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162407; cv=none; b=aUtlr1kNbW7Aa9eVo5jC5Qxhb+I0DkGgBLKHxESgL6AfyMsY4BXk3FMCWEp10/JlA2rhkNmHtI2iPrVQPpDsvKhacHPERND+o6DAbzSq4wOAS7nKDxBPPNtsZuTBjZyk2TAERLNNw/FRd0yvbsuWn1cizgITonI8z0hqQ4+XXkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162407; c=relaxed/simple;
	bh=uFX4zjvXso4VeDI316ejRhA10e98d4MoCS8GSbY45IA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=lTutBXlNCrLH3bKojRgV0E4qGz8XLpj1kr2JxQbwjWJ6gMSY0A8bQiCoALPlE26BJRNKxd3Vblee2g/qxlOqs2slHvbMURCBRYlb9sAaL7yzhauen4rWwHL4TEj0IfDXAN1A6tk21Nty9j/NzDTCbX1N9Wotiy91UdsZyxbPeZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLk84Qk1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLk84Qk1"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso48337a91.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792162405; x=1792767205; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uFX4zjvXso4VeDI316ejRhA10e98d4MoCS8GSbY45IA=;
        b=OLk84Qk1ZV32xXjKwIhWrmCRekh/R7+SIZ7FLJX2G7XZp1XkvUgoTQHHrBqIReHH1K
         cl+7hXXmcMNWMmagWjrJ8Ow1SJWO49mE75m9+vfeAfR6AIi3b+8/njr1rmGIIB3i/x/W
         LF8FXKSQIBf81NmAlA0KwVRqPJqcYWi2GBUdAx5s2KDtqAL29O92U1nQT7CBszxTW8zu
         3xLvLB09okAQyVqGEOZpsp/xHIhqjDPKrEvgWFawcXzio5KOqIAAn8KyF4tTChaCqsIn
         HRTGWDxoyG8bsIhsM7L43/TEncFh0LyPCdXkrV/5Ah37Ko6eNNMsINA7eQx8qtVwSx3b
         Zirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792162405; x=1792767205;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uFX4zjvXso4VeDI316ejRhA10e98d4MoCS8GSbY45IA=;
        b=n0ItfNFMkImQLt7RB9romhXOrESYiedwK1cDlKWpypoXtyVCDKzoDEBIMqjQke4SmD
         ihW/LCx8T/5tsJiLxJ5fLv4wMS/CS961fBzccQKcpfDfDMF45Gcqbr6HmsauaXn0qbIZ
         fG55NmL2wJnVhKTtZhmKCe3WgjHohhKzCDenRMu6/ZCZYFr0/4u/7gkZBlv3QoswYBmc
         OkdoOJSE5LehPEW8/MAglYq9wdHSPZ3g7GL9DOtc29gq0ijkafhWgBTxm14qA7cvBX5f
         rtSHces1dt+qhQDRxLlCoNsa8ybB93bkGAfeC4cz4oSeRAeD93IEPuKZk9h5LDOR1mm6
         OJQA==
X-Forwarded-Encrypted: i=1; AKwUvBzqwCL3FyPIkiIeXgIb4mjBWcNTms+0oBAoAtbHjAD+aiMAzkgj6S3x8//WIBNUBi6diSM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBRo2JJAwbXJuNExDtHN+xuVAjo6FbuAZqQQQtNpnHC1pbFow2
	o9WW6yhx31vavRIw2NL8u4RiLXVHcjB7XT6NSPdnQUoVZGk9lI3lHPu2
X-Gm-Gg: AYBFou13GFLzzn4mR1rYj+iSMp9P4BSdknnHHFwlSYM73Cbu6e4q9u4SebRl2FW8LvA
	mcBaJDNdX0ks1R53sKhpuscmZiQLvcHDnmQyc85bFYUuYJgpJ1GFfYfCTQIKpcH6kWtB3NlaErn
	V7GtZymbGd/vmuxDCkgZ3FPJ3OUKKP8l3wzctqx5jiOXQVW5AeIqVDUIcnVaiNX1Y+gZgSwTKe4
	mwKh/kYJdRPJgMQkcBbzCMVEI98RHXoYbJSR8AQmIgv/rc3jLN6GjAuffegkd7OlGeC5J5LV+m6
	9238XuocTcRtvlFU65/lIDaUjE+rluf7JONiGeC9cKWUhp/XnI+7ZidB7woB7dhWJ96uA0own2q
	aRkzx+wURuwZ1cRy5PrYfUPhhKH2P68jfUUCBZZtnCSn7AmJ0nssfD0FNMeZYd60WmnysJgxelG
	jTqswAjzVv42zlihTJs329WevDeom/HxDepWDtLABr2qQL5m2ipTZp+kOTS03djloOKQFyWYH5l
	wYTXVixGdU3KrqLKSJjl1z6RBjLN4La1BmfMlZRM9OWuQ0fM3RH4pZoKZjvbgS92S04IlAJmThS
	VWQ=
X-Received: by 2002:a17:90a:e7ca:b0:3ab:f38:2b3c with SMTP id 98e67ed59e1d1-3acef13eb0cmr59920a91.28.1792162404946;
        Fri, 16 Oct 2026 07:53:24 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9474b52fsm10875551a91.9.2026.10.16.07.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 07:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 14:53:23 +0000
Message-Id: <DM6CJUE4J2LX.2NR5QB5X3N0Y6@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Alasdair Kergon" <agk@redhat.com>, "Mike Snitzer"
 <snitzer@kernel.org>, "Mikulas Patocka" <mpatocka@redhat.com>, "Benjamin
 Marzinski" <bmarzins@redhat.com>, "David Howells" <dhowells@redhat.com>,
 "Jarkko Sakkinen" <jarkko@kernel.org>, "Paul Moore" <paul@paul-moore.com>,
 "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "Eric Biggers" <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Andrew Halaney" <andrew@amutable.com>, <dm-devel@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <bpf@vger.kernel.org>,
 <fsverity@lists.linux.dev>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 0/3] keys: Add well known IDs for
 fs-verity/dm-verity keys
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com> <20261012-broschen-inanspruchnahme-gebilde-d72cf2b99cda@brauner> <DM5UD20248FG.3BXPS76LK06F5@gmail.com> <20261016-ratlos-endkunde-eindimensional-1fe5eef08d13@brauner>
In-Reply-To: <20261016-ratlos-endkunde-eindimensional-1fe5eef08d13@brauner>

On Fri Oct 16, 2026 at 8:27 AM UTC, Christian Brauner wrote:
> On Fri, Oct 16, 2026 at 12:38:11AM +0000, Alexei Starovoitov wrote:
>> On Mon, Oct 12, 2026 at 12:38 PM Christian Brauner <brauner@kernel.org> =
wrote:
>> > Applied to the vfs-7.4.keyring branch of the vfs/vfs.git tree.
>> > Patches in the vfs-7.4.keyring branch should appear in linux-next soon=
.
>>=20
>> What is this branch based on ?
>> v2 was sent against bpf-next, because
>> commit 264d8fd2794f ("bpf, keys: Add a bpf keyring for program signature=
 validation")
>> is only there.
>> All hunks in keyctl.h, key.h and process_keys.c have its lines as
>> context, so the patches don't apply to -rc as-is.
>> And patch 3 documents KEY_SPEC_BPF_KEYRING.
>
> It's based on the portion of bpf-next that has Daniel's keyring patches.
> Which means I just wait until bpf-next is merged and then send it as a
> follow-up pr.

ohh. that should work. If it's simpler I can take this patch set into bpf-n=
ext,
so you wouldn't need to monitor merge window that closely.
