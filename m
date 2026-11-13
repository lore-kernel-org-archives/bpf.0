Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564841;
	b=gBczT85CUOTiTgNCR1gUbHNal9Y3DN0XCHJO6uIc2mW6C8XvhdlYv9JziegGjhmDtHPm
	 1IjqFGqYEKTJgZJMFJaJPeSx5QN6bahQuacXqc+EEPgaCrdRNZVoMF+35XuNGZs2iw6ky
	 xrTEAtNtQ/kTyqiwGXPTnRM6MkKKHErOtP1W6lZfp1qLIN9OxyZMeimA8PsRcD/DMPidq
	 iwh0m30YMLB6RkE8P9erXykvUgOplnAorPyOt/aaXxavgpXtfe254W0xO23c9QlcehGaI
	 Sjr0HIQSKPvfUBrO9vio/D+ou5qMhWf1o/vsRovIcVjIVRJR8DkWbe0LCzTFPRGUSWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=LWRhkHq/o14g3eGvU8PB/2eVsiZ8AcgjQiitoPu4Uko=;
	b=QVDzVt8Sm1Y1bcrn7v3nQGn6h9VnAQxBcmYIh3lpNnaNGwgIOir5YBq2N+1TiOCEFPfX
	 fYxgc33oWPT5Hp1qg2V5IJXRj1J9Rx00Htb9hisRal1yDXGh7hR1NdvSa9GvwxaYQFraa
	 34ZbTw5dyPcupU5rWPHuckZY9XY8yP5zXxUviM7uBDQdlJlq+cH02KpRoya0bLKeMzHuh
	 DjFsCCxwjD9n/y3HWSn8j+gGKIZXugXwQ2vOKkabCLUxT47/pUHl1ZOsCPT84f0JvbiBT
	 eqriA1MER24qsQ73xOejD1hPleT9B67pa484mbDC7duoQYDZG2OPNOG8xvETQ6onukA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fgkfOyvU;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3ED606A89E
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B3ED606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fgkfOyvU
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b001cd92bso590379f8f.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564839; x=1795169639; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LWRhkHq/o14g3eGvU8PB/2eVsiZ8AcgjQiitoPu4Uko=;
        b=fgkfOyvUu8xf6W8q9zChbNscxyQBBGlOoHgKBKJ1BkQkWvPVGihrF+rRK/++Rh9GyG
         JHspcfYOBNPixo8oPKNP4HMqn4Pm5ECxNu6WadiPSEV1Ef7s5pMOTmdpp1h0qheNYCAL
         reGCPjjBuRkeLgJtvMnJj51efD/XBAnW7OBUZupe3DEOpiY9mIzToOLvbGpl9PZAiITD
         ja/hKOWfLJ2HwVqW5WbU5vpLe4u/8sEd47rKsdelsOgJDSYM8eMKS9Bg+p1Lcupp+2o7
         A8nYundFQzH4qm98PvOkGZvKdsA4h3jxn0f8A/jmsMNUP8nMz4irJ6DT1xabl6IkGIEw
         iw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564839; x=1795169639;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWRhkHq/o14g3eGvU8PB/2eVsiZ8AcgjQiitoPu4Uko=;
        b=2bHubkUySBD5qjDV0qGbw0b1MgTlbf1s2jVU5bqBwoF3+BP3B9MuZkYIl0+YUA6MQS
         klCBX0f/v0c4qeMb9amu47qDSYFRb9rBeSTXlP3Dk57AOagLWoMgstHIZw+qcN0yFhfa
         yBHHbH7IDi8KqSTr6LqL2RdLMAncO/HnzMRkroSPCMePMYiLufLS1kZtF7NaR7QBkN9E
         jTW+bW8fatqBMhFvTjtRbsb0nwjS6H6pMILAG2H14KsY8fh/RnSyL41NggP9NOwNfmE4
         uGxW+IAS4PthaG2o+krVZhlC5Rd6cgUIW1rYePn7s5ULtVEl2B2+LMbingfUUpLw3LmW
         R8LQ==
X-Forwarded-Encrypted: i=1; AL+hErHHZRCE8cr5FI6+QOqEwRZBposkAqPWNGfzrbbignS9VyOlnDE/p3vRxl7054gJFFoaEx8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l5T4+4JXNdG4StZldhOafor8FipFKGExC4BwA1DlkwvPzLaNG
	XZF58owBktQoT/H5M8oWITyK4OM+3OH146ZjMjuwASqTgVGkiJBfXA4XJTJGs2NPpUH7
X-Gm-Gg: AYBFou2kruZoLVDgNg8+HVNuUfxKiD1OsskJY1f6+FR3HkKRVC2jZ98GtxHw8WXjiQc
	hNUKQMD/qwWwNF4A4pZatk2XteXSbt54DhHm/AEcWDQqEu6T5rfAgwUKA7CDrGjgAfdy2SIC2o0
	n38ZGXp8a1B89J2dVnNK9pWiiMKAFWj05B/Bn8LIP6PgOTdJzYDdibH+cVR7ihe8qG5Nb+yH4yq
	sSsnZvsivBYqsSOetGoLoVZEsVAaNTxQwACa0L9kF0RNrTBJ3xUrBABIIx91wPKcBiKkehdPuDF
	/DcaleMlYvjEMbute69sdUmOFAZJdzpLwrSrY3QaxWXtSAPCdUCmMY02mLE7Dt1wL8hti6dOfuA
	SlCfRS+bJr6BgMYejpf4MhTt9R/N9JOJRvryCGgH0yxqXREV75OArNlFoSbpubMEy2w8mKV4Tpn
	LlJi2OBf/Pa4EzeBbZsofIB0oGt6Eu6bJx9QmmamSXCnuDavCFFCH7Qy+FcohKHJ9uz8SOIamMQ
	n9qs7E8rWw9u0L0Glgjykw1aVtuITon0dvT7JpoowblXK9OJxh/DPR9pehIMV9EWVUsYJQK/dPF
	neC9POxs5JNYMzbM6U6uHJ9l7d/zMZIJgUXukudNRf24upxifKafekp/G4KNgw0=
X-Received: by 2002:a05:6000:993:b0:48f:bc59:ab9c with SMTP id ffacd0b85a97d-49c6fd932f0mr4358101f8f.12.1794564838578;
        Fri, 13 Nov 2026 02:13:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d673ce75fsm190118f8f.55.2026.11.13.02.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:58 -0800 (PST)
Message-ID: <77855be3fb9f0e1888c6dddc56d73a1683c820f0.camel@amutable.com>
Subject: Re: [PATCH RFC 25/41] pstore: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:13:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-25-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-25-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize pstore as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. pstore never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/pstore/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index cf499ba72702..4658561cf90b 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/ramfs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/pstore.h>
> @@ -491,6 +492,7 @@ static int pstore_init_fs_context(struct
> fs_context *fc)
> =C2=A0	ctx->kmsg_bytes =3D kmsg_bytes;
> =C2=A0
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &pstore_context_ops;
> =C2=A0
> =C2=A0	return 0;
