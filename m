Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904594;
	b=LQm05QvzJjAQNRfjxH9FA3KAUMX42PmOZv4XDrcF65dg3tBsUPOtBtr2IUYF8qAVTr4U
	 4WEURcUrF/wD6KFRbzF6EtXhyxr1KSzmPTFzxnWAma3IYWoTPa6jplw6L6qhtnOHb5kjQ
	 9QMqq+aSwyd+0JLsIbAyCL2gEaSsFk1PGBK0zc0ZLccA8ZPFj5RmMln1gKjkcUAfpTqZp
	 tOTYsSQPkebYl8VJ9b/5foRebn55H+aM41ojW7lg8lMZwxdGpAi4O24jLj7i/9LFmhqwj
	 qFbcPVqB/6BnGs1jp/1fSMLnVmNI12aLnhKpzpchDu/XUfaM8vq9TIdYtHziM39seAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
	b=mM8+ia/QZ+NIOSKoqPhW7CzEFajN279iUOivxghg38UB3ieaa25kVsy3n7gxzaxR5f0b
	 wCCMzS2iZSXJw/OMX1hQkFfeeelhJONh7PUr9GGDNjg2emLy1J2C3EjnN6Jqb/SzbRBQH
	 FLVtPyOK1Zx6HCpmhK+vrEzbkAuleDDtvPEsBaSHVVzT9C8WvbSgWYTiRz68JkVKeSyQ8
	 wKSDcyM04WcWTcqluorKb5D7/Y1T8Q1as6vWMjpVw4jKL5S7nhTAnVVlomdppI4bouTuL
	 n3+A18C/vk6c2En3ce9oLmPlAXeISFh1yd9/ngqSGGAmP04GfNgd4YVX51iEmmtKRHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VB84C1sh;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0599606A897
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 08:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0599606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VB84C1sh
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b467581b98so39088965e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904592; x=1795509392; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=VB84C1shjSG034pSk2oK3egXlQwWjuu3VjrdbAKPawk/Twv4Yif6yhPlbROFWtMgPQ
         3tz2NQZOgPBk3fq0QRZC/paJXFCSb8aJt/mhh+A0iXMTZvR4a2C4xo37cxqDT+bS5wyK
         cFfqQ64HX4H+WtOYlqmaNWk53bLD4rVzH3Dam/22N7EldMgTIeT60YiznWNjIzN+eEJD
         Zc6kl9xoD3REW2KAU35dfm9/7zuNgWUL6hteTTxoqyJmYKiacM/NYuvwNSKHsMwzezat
         1L4qftGlpMPZouPAaee8sA2dATEpRVvU+RzrgkUS2mvSj/+KFRi5Npjbd19v9tUdsF88
         Zbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904592; x=1795509392;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=XjO8nmRt5SoWxPn+MZWrfQ/5iJU+UnLHKUUFz+Lec2Y6Un0B3O4nm+Lo+NQiLFm7aE
         YFJ/1jnAum3xbY+RP2I1yt5b5wYthd4mGH/zQBZcA+r3yLIQk2B2ofwx+cNXmbW/Da40
         VmLb3TzAkbAzRD3WXQcSBIb8YIuIwEkxZ5Rj1PG1gyWqS0C1V6hC4EYAcv0sPN3nSMJx
         8m6D1gpfw6z2/h7CgshL2aWS7SOmnOekfqECYJiUtH5a437xZnfBox3UClv51bO31j/K
         vlsnezArPuxknBjhMPsaRlHVlPUTx3JkKyhNzNeruFLd7cxrbfH7aZTIQUs4ThCs4JYi
         zIPA==
X-Forwarded-Encrypted: i=1; AL+hErHoeqkP27vzKDj+keEvJHYImADTy4HD0rVjAyDCfmq0ntr2bkWIriPBF5g8ufCaxxbtT+s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yNlkNJtGNJtsG5ucnExP46EJhsPzQC/M+kM1nmEa08AW9iGlV
	emzvrzgK7mMixrsuYx4/ccCDG8AtJOiZ8DUdshhYrYs67LyOHYn1NgLscSIqs25yim9f
X-Gm-Gg: AYBFou1wcZX1CwO6zn8GjXrcuY6FBvb94MqxMK0o8ZSbGxpKsf4T6LDgvJ5P5M1iTs2
	MWcs/oQtkeUUHAY/81cjgE4Ffrj9qqsmPiQsblfnuzZKElFmYgBn5c2T0alfnIM287Mromuyr38
	yLPik5G6F72xasHQeRLZb/bkiissXIf+1dG13e7oBKDqRbOn8BtFCMry4p8hfbj7I7CnSSkPmaI
	lAvumXLxXFLbodI79Qc5B1y1x6SbosUUFdd1qr9PNUGak7puVpOQeNkT+tFsDvWo9F6mqZL4LRO
	bVmecmhdCZj91Q1lLzJhnte9mwympwsRZwoIgPPJ3bhk0CH5Dnl9b4DEQcFRBanH+vP/bXecUl4
	lyztasZzN1LqQJfwCCLTND7YLfmVm2vz5zK7a/GhwodNw9lrAEeJVo1hdzN5p5kKK9SGlb2OWdy
	L4PbReiXQKdTLg26WU80GVKuExsiPOp8thoQhJ6Kemdar1VD7WXgtCVg3/wgl7/DFrcFiBd7q+8
	8OnewRWwUbd7qtBfD2bXzQz988lwkHzA06mqEdIUx/NNe8vhOcDVG37hfGCtn1yOwRCsxFQTqEX
	a0/ppIHdctoKUk/dtcsFvQfLGlLfLFUCZn2WdOYir+Ovq742tLjvuWVJRHW8vWQTuL8q5hQCUgr
	giA6NlPQMqwR7AzBJI49Cgm8X6R0sX6CZ6W2NcPTyGU6BUU212JUPqYwr
X-Received: by 2002:a05:600c:1f90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb55ab281bmr266345525e9.21.1794904592167;
        Tue, 17 Nov 2026 00:36:32 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430752sm52548565e9.12.2026.11.17.00.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:36:31 -0800 (PST)
Message-ID: <411502f9a4f940c223b2b88d7e19fafdce63172e.camel@amutable.com>
Subject: Re: [PATCH RFC v3 29/44] s390/hypfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:36:30 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
> device nodes.
>=20

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0arch/s390/hypfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index 559b011e68800..8662169de477a 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/vfs.h>
> @@ -301,6 +302,7 @@ static int hypfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	sbi->gid =3D current_gid();
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sbi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &hypfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
