Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601008;
	b=wlWzLwhqqy/H49bMxydpVPaSW9q2e3JgIw8hBV7+50ZH0Xj2gZ8lE+ZrfPOgb5LuIaM1
	 l4Z6G8YHNrD0FujUOL6ZG0A5EEpbOqEzxe8OBoFB9W94ZIsyucDSuYxEbhQR230cQryyG
	 mb4g54A+rnGJjJMWzbjZoJQuhI8hOtC0axPpeFyiCyX3qjHw/olaDoVR5fYUjW5rIIawa
	 Hoy/gEScL2KZGAE+ZLRdqi6LSqphT3O5GsSfh4dvJ6f9l+SUn+vekpbMpHLLUX2ujBXTG
	 hh75beYr/7i7qXOgOd7NUIE4FwHtKb8B7UOziQzhF+6y0m4AnpA6YCwkJ2ls+hkJvVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=Ci8HQ01z2l/V3dvB0tBYdp+UGZOKQC242kExtdOTHs4=;
	b=V4tRwCqNhxAKTWMZjd/TEEvFjhPdV9hMz+1WpnJWZkmw4zBYbWiJK2C95lTuvWeO+4iU
	 oXJPkgKNtGCi9Qtaw8+8vCqUhMyburCtPV6SsbQvSs7yd+KjvCxCZuOXuW+pmK0Brt7/6
	 Nbo0m6JMswj+eVbcYL8IbHJcy6VKyl3DV4AIVL0i4h0Jq4OohlF26SQle5afEzpL1QMyu
	 3NY4yFmk80HyWFA9d/BiNPkmmfGTHfNb+AX6j50pTgd1GG+Of+u2hJfLTbnbyeC3sYo6D
	 /axm2qZNC6ZQDxi2eid0LhAYk5a4Apwzx4X+GucQTIod6dHv7sMlrX10AMcz8Zs8nVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DnvLvDTt;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59F606A32C
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE59F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DnvLvDTt
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso614153a91.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792601007; x=1793205807; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ci8HQ01z2l/V3dvB0tBYdp+UGZOKQC242kExtdOTHs4=;
        b=DnvLvDTtBy7cN7BNYpcCz9JwEHLw0xK8wVqv0zpzZSxW0EFrjl62Crt3/vzVL67jRw
         +wIovjXsjSRwuf+RAp5bOOnSWaPFGEEqtjEHnLW7DhmC05SYGcVROA8DULZb9lHCaZU9
         d0VgzExH93c7j0iXT4XTJWDqEpC9orlkwgzJr5CHgp0hspFkWv2c99CWEdBT0rMAD9yG
         pAFp7XHazWLDFc/uGPRsJpIBKCUUrUn8OzSrC+ozjQSbfCH1LqX2n8b3IJ+I/DTTKfRO
         kOPEu0+o+mA8gzC5wqpZNfh/5XV4F1c9g3u0guJPTTjuytALZVDeiRiUNJAyNScenoYq
         M4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601007; x=1793205807;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ci8HQ01z2l/V3dvB0tBYdp+UGZOKQC242kExtdOTHs4=;
        b=daap+eH0dBSZP0ejsLOIp4iZ6gaPCQ8YGtJmPTUxgjPQd/zZOTNg84yVPp4UJrm+KV
         PWNy4vBfLQgZVoqce8SgrVc+WNxyUiT2MHBbkUpcBzaBK9G46B8XXS3I5MDjF5bwvonH
         YskghkO6YNmjfv0/kT/R6pgjrP1NX5FgZxWd8PbwzI8D37YLlL0sYWj90lV5YDRKeihV
         Woj9xxJgHe5NKr5Og5V3xEoSpquF/wqT1CGNbPL5iqse0a/4MLbf8Jw/wPQdcznfPovH
         PYZNXV1x/+LRb4hqeFfyoTKLA9ng5YEDFNNM26kQLQ4K7O0kmPr/cFmgPwbt9iyqLtIK
         8D1A==
X-Forwarded-Encrypted: i=1; AKwUvByIW3S3THZiXeK/WVmhWQFypMZBs0cbte5y49t1UK7z16rKsk2to5dfg9HTPICKP+zxU/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPexARW7cYlnW/Ea90twEsGhdmdwKdzg0DHdMs+agV5SHRF6jz
	OPs7iUkmzB8neI0Ew7N33KqP7IFO4NEeB3Gg5F9nGyzSQeku27PuBJWj
X-Gm-Gg: AYBFou26gFdXNsb7eUax72sJNE82Suoacj1nG0UiB9wuYefy26X1otQpU0xpVQELM6S
	OcE2S75Tq2wHeg0B4ObWItPH00x9mkVhZAyqV8HyB9HA/LJUCDvXhPU9o2JhoMLEY53PijmhRtd
	BvMp+0Vt3uuveWG+uhQ8L9/eBkTPZgxXw4XTokyQBcDXRO90UBwTHz/SooBQQ2A6vRk0lu4Cjq0
	5zxDU7jKhD3u8WGCFquQE8BwQSahV6jGNH63g6FeN7e2GzAJ0hay5C2waVQfjcJ6x1CI/Aq3q6X
	DWvaE6hVJihjT3zar2e3mN0nnlsyZAoaGxpkIF86cTHknb/IgR/+SXbMCG/ayoYa1kp21ICMGdk
	5tMFHZomCaBuzeeo3CzM6tJ+rNigiUPf/wGz4jALNJBlzeIweomgu2oCD158KkTAnsyPav+Hp9p
	RxuTpTnRRliSRkPAn/nxqMdBP8XMETm9bgI7Kre7seV5NBtXEuBHbVywIVb/ioEsd+HH0TEIkDi
	uf9MeugcP9cEz00tEYpaOk+ofZF0l8g0BRwHdMY65ywKS/DXghN19a2syGD2RHXcMLQ7DS0+XAo
	IzFQ/Nk21Z2s6X6LHRYacDgawsRLZh/J3m+K0UCrWUUmasG01Oh3UPXFbK/VWQ==
X-Received: by 2002:a17:90b:514d:b0:3a8:699f:959d with SMTP id 98e67ed59e1d1-3ad86d55b29mr2259973a91.31.1792601007016;
        Wed, 21 Oct 2026 09:43:27 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b84b513csm257161a12.12.2026.10.21.09.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:43:26 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 16:43:25 +0000
Message-Id: <DMAO0T9BL4YQ.2B3YU3ON26N6L@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Hangbin Liu"
 <liuhangbin@gmail.com>, "Martin Karsten" <mkarsten@uwaterloo.ca>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Pass extack to bpf_xdp_link_attach
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261021152455.71524-1-leon.hwang@linux.dev>
References: <20261021152455.71524-1-leon.hwang@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 08:24 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>  	case BPF_PROG_TYPE_XDP:
> -		ret = bpf_xdp_link_attach(attr, prog, log);
> +{
> +		struct netlink_ext_ack extack = {};
> +
> +		ret = bpf_xdp_link_attach(attr, prog, &extack);
> +		if (extack._msg)
> +			bpf_log(log, "%s\n", extack._msg);
>  		break;
> +}

CI is right. This looks odd,
but instead of CI's suggestion:
        case BPF_PROG_TYPE_XDP: {
                struct netlink_ext_ack extack = {};

do something like below:

sock_map, netkit and nf links will probably need the same when you
get to them. They can take &extack too.

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1d34ece..5926f13 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1269,13 +1269,8 @@ __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
 				      const char *fmt, va_list args);
 __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
 					   const char *fmt, ...);
-#ifdef CONFIG_BPF_SYSCALL
 __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 			    const char *fmt, ...);
-#else
-__printf(2, 3) static inline void bpf_log(struct bpf_verifier_log *log,
-					  const char *fmt, ...) {}
-#endif
 int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
 		  char __user *log_buf, u32 log_size);
 void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4548b0f..f5d6438 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4418,7 +4418,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 				    struct netdev_queue *txq, int *ret);

 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
-			struct bpf_verifier_log *log);
+			struct netlink_ext_ack *extack);
 u8 dev_xdp_prog_count(struct net_device *dev);
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 87cd122..0ce75ee 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5865,6 +5865,7 @@ err_put:
 static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *attr_common,
 		       bpfptr_t uattr_common, u32 size_common)
 {
+	struct netlink_ext_ack extack = {};
 	struct bpf_verifier_log *log;
 	struct bpf_log_attr attr_log;
 	struct bpf_prog *prog;
@@ -5944,7 +5945,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 		break;
 #ifdef CONFIG_NET
 	case BPF_PROG_TYPE_XDP:
-		ret = bpf_xdp_link_attach(attr, prog, log);
+		ret = bpf_xdp_link_attach(attr, prog, &extack);
 		break;
 	case BPF_PROG_TYPE_SCHED_CLS:
 		if (attr->link_create.attach_type == BPF_TCX_INGRESS ||
@@ -5978,8 +5979,11 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a

 out:
 	if (ret < 0) {
-		int err = bpf_log_attr_finalize(&attr_log, log);
+		int err;

+		if (extack._msg)
+			bpf_log(log, "%s\n", extack._msg);
+		err = bpf_log_attr_finalize(&attr_log, log);
 		ret = err ? err : ret;
 		if (prog)
 			bpf_prog_put(prog);
diff --git a/net/core/dev.c b/net/core/dev.c
index a142613..d79a589 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -97,7 +97,6 @@
 #include <linux/kthread.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
-#include <linux/bpf_verifier.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <net/busy_poll.h>
@@ -10773,11 +10772,10 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
 };

 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
-			struct bpf_verifier_log *log)
+			struct netlink_ext_ack *extack)
 {
 	struct net *net = current->nsproxy->net_ns;
 	struct bpf_link_primer link_primer;
-	struct netlink_ext_ack extack = {};
 	struct bpf_xdp_link *link;
 	struct net_device *dev;
 	int err, fd;
@@ -10786,7 +10784,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
 	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
 	if (!dev) {
 		rtnl_unlock();
-		bpf_log(log, "Invalid target_ifindex.\n");
+		NL_SET_ERR_MSG(extack, "Invalid target_ifindex.");
 		return -EINVAL;
 	}

@@ -10808,15 +10806,13 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
 	}

 	netdev_lock_ops(dev);
-	err = dev_xdp_attach_link(dev, &extack, link);
+	err = dev_xdp_attach_link(dev, extack, link);
 	netdev_unlock_ops(dev);
 	rtnl_unlock();

 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
-		if (extack._msg)
-			bpf_log(log, "%s\n", extack._msg);
 		goto out_put_dev;
 	}


pw-bot: cr
