Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06E46D2CC
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659108; cv=none; b=QXVXT6FIMn9MkNCO8EvENrXWCEh+Yja6WNJ1e3Pn7lEWc8N2pKmC9FRNplRThcKnXYjBMo1k+uiP5j+JTdrbVsfvS2NcwO2+Ilt9/f+rQIZspB/xQDQbgR1ju7egyU1AqsAqPGJJYedVLyesDidHLpHucQda/CejTP5Ygl8fdjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659108; c=relaxed/simple;
	bh=nFMZkC6MFhZO41bV/qEQar9Fqbs9a4q5U52SS8xj06Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=J2LZRzcKiaS5xKYpv67RwuxZHtIB03fkjtrR1Xr/Ehghy17xOv7Rmc0o25uCpTUYkS8/orsA/AANIAFYGdHeBAKb75IiqundZ8NwOua89tXNjYwlR+5YUPMdDHB/W01D93VXj37v68JmNog3okAx74LfkzAbYtV0ozm6pLml3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=yGjYxqbu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="yGjYxqbu"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e347638adso6776835a91.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784659103; x=1785263903; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=laCbyrDADvn5u1fSkRd/6IfFVMa2YUzQg3u8hQpf/yg=;
        b=yGjYxqbuNOOt/BS4Fy39217QhzkuNzI74i4xUBW22LvZA+heSTqnpOKzQcjxwJYVQY
         9X8geHceK/K4cXulkPYc1UfAZX+4HxTnDiFkfPM8x4pSGpgW5m+Y9lSKa/lmqwtdItns
         myl1UjdgUZgheQdU5qJi4tLo1tXYXyfIsXMrRAuSjuwAddtcnbO7fnWfQaQ/UneLHsNH
         D/IYi1qvPHpJSgCXhEeUYVuHaDtaCxzeCVqZOljqNdoPCmqf/eIZdW5rmQzup8k/auwb
         PgdHIEF2H1a98LodSe0Y+7iQES7gkK5fo/yHdhIYL4Y65kmpjkD3GDqiPgN2lEMX7roc
         q/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784659103; x=1785263903;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=laCbyrDADvn5u1fSkRd/6IfFVMa2YUzQg3u8hQpf/yg=;
        b=m4Z3x5sBdKqKxEa6D5gilPqEr935+7sL9w1TxO+r38ECRyQKbCqpKgIwkB4c85qJTi
         KwgJObtc6WWpEBWBYWvmlBSteGSy0tH6fhS1G28f49NKYPcPhphQrFO1myOkdcnQ5DXa
         TYhj4heo1MOqRFfpqrDVN4RJyGMSW/frC0HpTui4jw3STEJ8DAjpLRsObuMQ+k53E85S
         LfxHQyF3Zfs87WAIaAQtC3dMSJyFON7qPvsP2JNa17LNQZdpF6Zr8gwmNaVh9Oit5cEv
         uebyZci9QBsXksVp2r4gYZHCwq0j74A2rYOgi71p2gcjXnOvhoh1pvj0mWh+bg+mq62v
         A3Kw==
X-Forwarded-Encrypted: i=1; AHgh+RrM99oeeLa5mb0lVQw0PtfoAJAeY6mfJqnYdaRJtf3PR0P6LtpGdUeVr0hPRcz3njx5MNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsq0vwAMhgsSw89ehpp5JtSXSYvG8mXg1cpVyCjJ3Gp8UWEknX
	TPJJ4rtRcP+0Uq+76n74ezslhTEekZjxy9CKJ7mPL8q2rEOOx7gfJZBzi5iKMgqNkGs=
X-Gm-Gg: AR+sD10LL1HVelCahWLyq6w27PRS2kBWAM/G79l42vKiqCKP36hi34xBCA7cNgDfr2H
	jXiHeFpzlBkhNW8HCRIjaFbgOz4heELxZd/xZmiyYq8eU3P88EbvoeqRXQT+79a9F0TGRYFIuo7
	OShNGFGg/vIDV+sepLSRW+j2f82ivHDtQLfaqL/QonvXo7aq6n6IjhsaVo8j/C9eiHj2yfBSwD+
	vTJO8pifvrtjM1et93cy31JFVeogizKp/SjY6icvRQfHeU5lyoh2QV0QhBFiBoCVAsRtVlUTl8j
	N8Cm14KLfslmZwxyFCyEYoTXY66jmNKn5iQwWPft75Mg0l7A0fvi3G65jN8iWbaGAOX9EW6J8EY
	tg/CCFIIG3/T4PItf1k9U9sRQMKOargcTjLOZJnmZkoc44WU9aN1OMmCxDJs=
X-Received: by 2002:a05:6a21:a8d:b0:3c3:a490:9674 with SMTP id adf61e73a8af0-3c3ada8c6e1mr21386953637.64.1784659103080;
        Tue, 21 Jul 2026 11:38:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::4a7b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2a18a47sm45874614c88.8.2026.07.21.11.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 11:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 14:38:20 -0400
Message-Id: <DK4GUOJ1F4UY.20HLHNS3S63BS@etsalapatis.com>
Subject: Re: [PATCH bpf v5 3/4] bpf: Fix potential UAF when reading bpf link
 info
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Pu Lehui" <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Mykyta Yatsenko"
 <mykyta.yatsenko5@gmail.com>, "Amery Hung" <ameryhung@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Pu Lehui"
 <pulehui@huawei.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260721041048.1394085-1-pulehui@huaweicloud.com>
 <20260721041048.1394085-4-pulehui@huaweicloud.com>
In-Reply-To: <20260721041048.1394085-4-pulehui@huaweicloud.com>

On Tue Jul 21, 2026 at 12:10 AM EDT, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> In bpf_link_show_fdinfo and bpf_link_get_info_by_fd, link->prog is
> accessed without holding any locks. If the prog is concurrently replaced
> via bpf_link_update, the old prog can be freed, leading to a potential
> UAF issue.
>
> Before dereferencing the prog, both normal RCU and RCU Tasks Trace read
> locks would normally be required, as BPF_LINK_TYPE_ITER supports both
> non-sleepable and sleepable progs. However, as commit 57b23c0f612d
> ("bpf: Retire rcu_trace_implies_rcu_gp()") clarifies, an RCU Tasks Trace
> grace period implies an RCU grace period, so holding only
> rcu_read_lock() is already sufficient.
>
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active b=
pf_cgroup_link")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/syscall.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b47..cad986807d53 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3471,9 +3471,10 @@ static const char *bpf_link_type_strs[] =3D {
>  static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>  {
>  	const struct bpf_link *link =3D filp->private_data;
> -	const struct bpf_prog *prog =3D link->prog;
> +	const struct bpf_prog *prog;
>  	enum bpf_link_type type =3D link->type;
>  	char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
> +	u32 prog_id;
> =20
>  	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) =
{
>  		if (link->type =3D=3D BPF_LINK_TYPE_KPROBE_MULTI)
> @@ -3490,13 +3491,20 @@ static void bpf_link_show_fdinfo(struct seq_file =
*m, struct file *filp)
>  	}
>  	seq_printf(m, "link_id:\t%u\n", link->id);
> =20
> +	rcu_read_lock();
> +	prog =3D READ_ONCE(link->prog);
>  	if (prog) {
>  		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
> +		prog_id =3D prog->aux->id;
> +	}
> +	rcu_read_unlock();
> +
> +	if (prog) {
>  		seq_printf(m,
>  			   "prog_tag:\t%s\n"
>  			   "prog_id:\t%u\n",
>  			   prog_tag,
> -			   prog->aux->id);
> +			   prog_id);
>  	}
>  	if (link->ops->show_fdinfo)
>  		link->ops->show_fdinfo(link, m);
> @@ -5535,6 +5543,7 @@ static int bpf_link_get_info_by_fd(struct file *fil=
e,
>  {
>  	struct bpf_link_info __user *uinfo =3D u64_to_user_ptr(attr->info.info)=
;
>  	struct bpf_link_info info;
> +	const struct bpf_prog *prog;
>  	u32 info_len =3D attr->info.info_len;
>  	int err;
> =20
> @@ -5549,8 +5558,12 @@ static int bpf_link_get_info_by_fd(struct file *fi=
le,
> =20
>  	info.type =3D link->type;
>  	info.id =3D link->id;
> -	if (link->prog)
> -		info.prog_id =3D link->prog->aux->id;
> +
> +	rcu_read_lock();
> +	prog =3D READ_ONCE(link->prog);
> +	if (prog)
> +		info.prog_id =3D prog->aux->id;
> +	rcu_read_unlock();
> =20
>  	if (link->ops->fill_link_info) {
>  		err =3D link->ops->fill_link_info(link, &info);

