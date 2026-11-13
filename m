Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564728;
	b=x/WafwHyjyTX0RSpz7muH7QvC7GuaQIAhjjmEez3UrRMPN5vWa0uX0lSu4g7Xr2AgDiO
	 YdC+z33Iq/BTK7OFkzkgM9e/TzR4rK8Uw7To328bRuDxrPpBM83NReW1TaQhpBy+L1Gdc
	 4vwjrPHgziSkIdj2T+9xoSukC6Pys7COAvv7aEHFCEPwR55vhTPFclP+V5eMW3N+a9mLM
	 qgnu/Yj3JXQO8qNjCin3ppCrIzK14rHIKhmjV+HnlqK0CboAqodvSgx99puNex6sHthGK
	 4jL7k9KbNtd5E1fXnP5Ij/ue3C9OfnJ4HjWITsR0eooYel5cz1gOWkNgWkZGMjtnOMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
	b=heQ/JJWRxeyF7pgZiMUpUQJhp21WtgM/SWazj+IJxjaxOI8IwC1cBtEcNZTzaSt9nys2
	 9fmDpBvNvG5STJCA8LVdeDRn1J5gTazC64NpWRIaFZQltljOXiwM20EF8Re9Gjp0X153w
	 MywIiKfgQw0+Zp4kVMDRsXlLvCvvTdBiuN04p5wBzbkNamDX9canlLqKp6HMvQspFtUyf
	 8fNIGvwQWRE2zYrBVd/JZlyEV/Z0cwAp/K4OM6lXLyNWhSveVLcMXRc9yrMwJEuLVgCW+
	 jbSJrFhWbA+BCySOpLBUgO2E6aYt+oUMEFOIMCa8GKljiXYrwqsHIWpKlF6fQG9Vi/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JofFrwon;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3F606A332
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAC3F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JofFrwon
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so10660855e9.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564726; x=1795169526; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
        b=JofFrwonLml2YmEXhdcViuKQhdgodt9TPfkjQoH5bRE5MuhkX9eapeBcuLoN9BMOMG
         mg62x7tr1NIo2ce3//xfxGBo2Glw1JnMwrRUE5PKg9cgXRmANAsmerUzgfn4I+APSoic
         nLUkrr6h7Ej/6ZnsBOEx8OEPXrCx3CvMaGkTszs9w9WOs3gF62hftbL3MH/tr8iwAkM5
         IEqdn+20vI39qrHT5Lu5B20ux21tBPJwfptIyU9tNUhlU5QyFDk51k8ZhbiJowoQswf0
         13eatahih0uhEB44iQMwucAarD0vNvZBAG3aTkRmepVuKD8cgol5N6Bgv+DPTP+kX4Yt
         YdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564726; x=1795169526;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
        b=cO9VN4ALC2vQBUiqblIET820rJhhdtub9MmWnhH7n0Pr06itCIY6/H2iMqyEyDeTjt
         WMttVUBQH+jUq/NC3/hrjfcyeCVEc0279L+/cXKYLSA4cvMC+MeYtHoDdZLUqxIPrPsy
         FIMWtkezA9w+CTM0saJUerEsU9d4ruM+V9yUy7C/nJa1XfQLRUICS6MB6bjIf4hwAUEX
         THIJA5p7/cLRkyBHfKr70Rc6gaWpEan/uOVd8QtOcfUHxLFCqJXN1rpZEp+ai3pFhRvI
         nBuOKc/8QrohjZS7Z1xm+toqZB2rOGRtZu1fpRa+ihtASP9LlhSeVotEZHJtKAnvbKRD
         rBPA==
X-Forwarded-Encrypted: i=1; AL+hErFkGeh3505u1e/WD0VC2Kv8+7cSTTBkmvl9KFYDDQsCjhMXYWdkRrJ0NX99xmjmLkwKcNo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dEh/jVfA9+wpti/nbft45l/6KzRQYyS4jyQg7GdNmbzGw4e3/
	4/ZxW+1SNrcHkWw/Vng/gmVDwLmA8jsLS9kyeJB7Rs6b6r7hZEwJXScJs97qZ1SC4S7Z
X-Gm-Gg: AYBFou2bMJ2+I13B+pBGuqSaYdrrHRFlTBX8eVyjQ7i/tGI46U2YzihV/wVqsvm3Rxj
	8LO4sknjdkJOTzmej8xmbumwLq/n0nQ9kevqdkAiMD6RmbUuJQLtQvDIKhcwopVuE9cAet1cxsM
	icnLtdQxzV1p9oeMs6XQBVOdgsgUWaq2FKElY1XfsqWn5e1q9ySQr0WcIcZsOLyruII5jPq1GkV
	Xta2ophbIUuPoHUoj6k/KPhVzn81UNbOEO3DRxFPT31exc+I5EyjK0MA7wVXoXrlNUXYHsQb0xD
	1jqzIZjUv39QkNiDeoe8a9I5OFSwKk6Vlo9tkLXaITA7AdnH7FYZdv9uuzbOAFz4eg4YNxe/bSN
	E1mMJ0h+IOfFsVCBW721yZCSjkV1WMv93F9DMMkUEcV/xTgPGoHHWy7iF2x+GZzgWBAQ+XFFL0w
	1BOs7NuD9t/ylimI2wnDHGUmlAzByCbmlcPizyTKzZll/cjoX1aKNeFCxp5KvBS67YYX2wIiT4t
	vvbu2toXPsrptg5eYLGCP3Wr2vzWOad2vhPGTXfepF7f85w9kev08toI4ifNIu4B3peBXs5sCCq
	IaEgHJefn9J6yqVp76LfywB6IycB0XjAt1LfKjuL9pYMRpuPjLHvqs3861G+OV3emgctU7COIAQ
	Tmcr5ZAgy
X-Received: by 2002:a05:600c:c4a3:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb55a02932mr40317635e9.1.1794564726124;
        Fri, 13 Nov 2026 02:12:06 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2842e6sm142085915e9.4.2026.11.13.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:12:05 -0800 (PST)
Message-ID: <82d691d2db7579d9630bf89f73132e36124bf74e.camel@amutable.com>
Subject: Re: [PATCH RFC 19/41] smack: use fc_init_pseudo() for smackfs
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
Date: Fri, 13 Nov 2026 11:12:03 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
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
> Initialize smackfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. smackfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/smack/smackfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index a72bc7fabea9..4a56bbeaeca3 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -25,6 +25,7 @@
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include "smack.h"
> =C2=A0
> =C2=A0#define BEBITS	(sizeof(__be32) * 8)
> @@ -2880,6 +2881,7 @@ static const struct fs_context_operations
> smk_context_ops =3D {
> =C2=A0 */
> =C2=A0static int smk_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &smk_context_ops;
> =C2=A0	return 0;
> =C2=A0}
