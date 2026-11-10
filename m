Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316821;
	b=HRYic5hdD8di8Zu4QLYj1k1sYohd67EMEYlZZvVFaDU40qBAeHte+6/zC+HuZGYsJeY/
	 E5frCd/mFadocfsDEeokFJ4/n3+zXmIz4N7pW+veETb2Lf98Xm2iXlpWA0cPJYAcD7Let
	 E3mL24SYtITNyymCo3IjNti+jB2UAP81HBIB7CJpXWthQwLGJ8WFNrraduV89N6bb6MAo
	 JPmSYhPQusxmfCqKS1X70f5+t4usndpD5a7rhUvSCOs84HApRPxKEL+TTAZUEYRwpuGxH
	 JGIJ5L2Kwjt/jGs5snPZ4xh14jCS9jZy6st8xro5ATmoD5K34w8Lk0Di2d2x5uQA2pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316821;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6Y7QVx7G1MN02E+ysgPRqko/xyke3gT627Z3+xepCco=;
	b=SZFrS0p6f8YU3+XSLXnq0Udw0hR7MsHqjEQJWsx6ryubZ8dB5mRnnqn+aSB8Xpj2iwm8
	 Eyn/PmT4S/dkXyKtsapwssa9qLzoyQAe8cwlKjohS+06Jzr8uzlY92jbUFDeQZybz/pVg
	 saQgjqZtdviP59FMm0nyIRU3luiT6JxgUBVuUFNyvHS/xlr0e7aEkBHEOR7otoWThJhSW
	 30kLfOVOhe27o4whWeQpiTGcME+fcr/XJQnUgRCWwvVe+aseO5KMrpHk2eUNYp7A9DtaK
	 GXIig2sH2f9cEI9Wvcr+c0Sam7PI0C4v/yEANa8/kKFNEWNGpC+itLDGmLb9XVjrDzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZwDpout;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=V+L4MQf2;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C75560A381B
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C75560A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZwDpout;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=V+L4MQf2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y7QVx7G1MN02E+ysgPRqko/xyke3gT627Z3+xepCco=;
	b=TZwDpout5q/kwvHvB6LrbY5JEAKhNm/7IJj+T5OIIWe/Kr8pqEDAgdDQ9DLRwTBciDj+dn
	4Wv91KE0lWmJfnEQvp9BJihwN8l/J06U/fZwXfO/IC1Aa4JsiF9gwRHooVus7g1A/R16Qk
	IEx3p3SBEK/o5Nqz5FZ4MWeOPJbdS4A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-KI04gYntM3uEPZoHpZzpIQ-1; Tue, 10 Nov 2026 08:20:18 -0500
X-MC-Unique: KI04gYntM3uEPZoHpZzpIQ-1
X-Mimecast-MFC-AGG-ID: KI04gYntM3uEPZoHpZzpIQ_1794316817
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c25501f4aa2so274443266b.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316817; x=1794921617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Y7QVx7G1MN02E+ysgPRqko/xyke3gT627Z3+xepCco=;
        b=V+L4MQf2V/f8l+1hgny6XSIxT9epFwVQtd1EiYQrbbofwz6u7uNGPCKeMr2UcBX16C
         /4EI2lOOflS2gsyoHKI/gpLYXkJ7o8MFPGYhmqXC6SCzeM+eCuzfxf57mPKlypH40qUh
         YHqrpUUcytsH7QNVtR328ftiN/fZtjGg5F3m9pYchMjz5DtjQGEAtv46IK9yCmh9Cubp
         yFYBESZROljsfmosnKdNRDVVpQjDlshhFDem99CG7soh4UB2Q2sM9HUJu9ZjYFN6ydoq
         PtioevzmR7vn33EvRMBDGbhDNI7hOrPDp0PbSVWEwh7MhFigU80/AVSfzrMt16RxBHyj
         61NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316817; x=1794921617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Y7QVx7G1MN02E+ysgPRqko/xyke3gT627Z3+xepCco=;
        b=x4reLivyHleYOX38kopaOnzIYjlCdT+GNWL6D5CusBiHAyYxG5/rzmUA9s/NZof3Ow
         kMpEg7RnzFDPPxiPHanBorOqiRyivLnceS3Vej9r7FfSqI0IGirrK6LUAJXWzj7AmI8H
         U9/U59rOnJclhpXaoBha6Mw7mn958Rw8gUl3MbZ1PiO0D4LY4nFQLZO3zII4m7cd5VO5
         FUtr8oFLxEmjMK62ED98YfKyFPB5IhzpiBmVOirVZi5XTKgf+WygGzY/06hCr02Wf5iE
         at+nB5bDwtrkZeGXax7aquD+brZ+2KJcNq8hXExF9eIIY8vftpieKQxs5rhRR+iujVbK
         cgrg==
X-Forwarded-Encrypted: i=1; AL+hErGyzFmvLKp+c6wj+anKcOkWz8ovnuz7hNmrsd0GTEuqUIgC4M4i1TJmQEusylgNAAAT1sQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/g8VTQu2q+TyvfNLrIMaQIa+jzMkJpXstX8wQrL5EDgBnsT+H+
	fg0z1YLJyfwgKVLvB7tPd6U0s6WMsrhp8z4VCxgRVMol8fa1b10EsV/Z5LiCzwAReiQlxG165rv
	UOZBKAaA7pTeketAtAdbL9Qk0SZFp0Yr0STF9/aEBf5Ebn2vpldixGQ==
X-Gm-Gg: AYBFou1VSvW7jghwrlWMPmXPMXed5PSk+pZZBd2kPndowF9nsKjzym25fFzvYHcvDuL
	eAT9h5saOJx8kv6uhS8uVINBHViyIM/7z2in5KM5BZeDtEgB23Q8DEZi/4wlJgfAafWG/DCtXgn
	9bKLFE1CkXtOzs6E6P8m7srL/ear1OBIm1OOQZHJdTFCC68DTIYcxSZHk0IfpfLHjdXI0x/U/BK
	eclCSvTSwsijE+UTk03IRWXgawME2nuIJnTseyIQBw3Tgk5WwR3qHyIKIb6d9O6dS5wHHH0nA68
	EyfsaKIQ7oaBktR5+brcg6/uH5sewk77gGhjWEWPAaWyFOVAj8xCNmdhexYbTdERrHCG5fXzj2K
	5f7tiVfAfIe/uzhGf6NSI3oAYj7ZvmDr+eqZABJRHpsf9HN6jk9c03NeuxUG5kZ3Q9M8gx9e2wG
	WEaFagWpsSpq02DlxlHiv9UT8Tn607eQxbx5c4J32197yC4HOdE7zAsPoxAnbnx57stVWNF4XLK
	WDYi8lKqbG3Dwe7b0Bm39l0MFZt8obYg6HmQSfQn5wOFM8lijBk
X-Received: by 2002:a17:907:9b83:b0:c2e:1b6b:8b19 with SMTP id a640c23a62f3a-c5048c13001mr207598166b.23.1794316817188;
        Tue, 10 Nov 2026 05:20:17 -0800 (PST)
X-Received: by 2002:a17:907:9b83:b0:c2e:1b6b:8b19 with SMTP id a640c23a62f3a-c5048c13001mr207594966b.23.1794316816822;
        Tue, 10 Nov 2026 05:20:16 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5d54bbsm107791166b.48.2026.11.10.05.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:16 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 06/12] io_uring/opaque: allow rings to share a store
Date: Tue, 10 Nov 2026 13:20:00 +0000
Message-Id: <20261110132006.3280986-7-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110132006.3280986-1-amarkuze@redhat.com>
References: <20261110132006.3280986-1-amarkuze@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A multi-threaded server often uses one ring per thread. Allow an object
received or created through one ring to be used through another ring
without copying its payload.

Add EXPORT and IMPORT controls to IORING_REGISTER_OPAQUE_STORE. EXPORT
returns a close-on-exec anonymous-inode descriptor; IMPORT registers its
store under a new ring-local ID. The descriptor cannot read, map or poll
payload. Handles and stream tokens belong to the store and are valid
through every ring sharing it.

Each registered ring entry and export file holds one user reference and
one lifetime reference. The last user stops the store; the last lifetime
reference releases its memory and accounting. An export file can keep a
store alive after the creating ring exits. Import preserves the store's
memory-cgroup ownership and original ring user/mm accounting and adds no
backing charge.

Export reserves the descriptor and creates the file, copies the number
to userspace, and installs it only after that copy succeeds. Failure
unwinds the references and descriptor reservation. Import erases the
new ring-local ID if copying its result to userspace fails.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/uapi/linux/io_uring/opaque.h |  3 +
 io_uring/opaque_register.c           | 84 ++++++++++++++++++++++++----
 2 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/io_uring/opaque.h b/include/uapi/linux/io_uring/opaque.h
index 692daa7d7e32..9a129b5da5af 100644
--- a/include/uapi/linux/io_uring/opaque.h
+++ b/include/uapi/linux/io_uring/opaque.h
@@ -16,6 +16,9 @@ struct io_uring_opaque_register {
 	__u64 __resv[2];
 };
 
+#define IORING_OPAQUE_REG_IMPORT	(1U << 0)
+#define IORING_OPAQUE_REG_EXPORT	(1U << 1)
+
 /* config/config_size select a size-versioned configuration on creation. */
 struct io_uring_opaque_config {
 	__u64 hard_limit;
diff --git a/io_uring/opaque_register.c b/io_uring/opaque_register.c
index 9e39d1ee5072..472c739a17de 100644
--- a/io_uring/opaque_register.c
+++ b/io_uring/opaque_register.c
@@ -15,6 +15,50 @@ static void io_opaque_unregister_user(struct io_opaque_store *store)
 	io_opaque_put(store);
 }
 
+static int io_opaque_box_release(struct inode *inode, struct file *file)
+{
+	io_opaque_unregister_user(file->private_data);
+	return 0;
+}
+
+static const struct file_operations io_opaque_box_fops = {
+	.owner = THIS_MODULE,
+	.release = io_opaque_box_release,
+};
+
+static int io_opaque_export(struct io_ring_ctx *ctx, void __user *arg,
+			    struct io_uring_opaque_register *reg, u32 size)
+{
+	struct io_opaque_store *store = xa_load(&ctx->opaque_stores, reg->store_id);
+	struct file *file;
+	int fd, ret;
+
+	if (!store)
+		return -ENXIO;
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+	io_opaque_get(store);
+	file = anon_inode_create_getfile("[io_uring-opaque]", &io_opaque_box_fops,
+					 store, O_CLOEXEC, NULL);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		io_opaque_unregister_user(store);
+		goto put_fd;
+	}
+	reg->fd = fd;
+	ret = copy_struct_to_user(arg, size, reg, sizeof(*reg), NULL);
+	if (ret) {
+		fput(file);
+		goto put_fd;
+	}
+	fd_install(fd, file);
+	return 0;
+put_fd:
+	put_unused_fd(fd);
+	return ret;
+}
+
 int io_register_opaque(struct io_ring_ctx *ctx, void __user *arg)
 {
 	struct io_uring_opaque_register reg;
@@ -38,19 +82,37 @@ int io_register_opaque(struct io_ring_ctx *ctx, void __user *arg)
 	    !mem_is_zero(reg.__resv, sizeof(reg.__resv)))
 		return -EINVAL;
 	reg.size = sizeof(reg);
-	if (reg.store_id || reg.flags)
+	if (reg.flags == IORING_OPAQUE_REG_EXPORT) {
+		if (reg.fd != -1 || reg.config || reg.config_size)
+			return -EINVAL;
+		return io_opaque_export(ctx, arg, &reg, size);
+	}
+	if (reg.store_id)
 		return -EINVAL;
-	if (reg.fd != -1 || !reg.config ||
-	    reg.config_size < offsetof(struct io_uring_opaque_config, __resv0) ||
-	    reg.config_size > PAGE_SIZE)
+	if (reg.flags == IORING_OPAQUE_REG_IMPORT) {
+		CLASS(fd, f)(reg.fd);
+
+		if (reg.config || reg.config_size)
+			return -EINVAL;
+		if (fd_empty(f) || fd_file(f)->f_op != &io_opaque_box_fops)
+			return -EBADF;
+		store = fd_file(f)->private_data;
+		io_opaque_get(store);
+	} else if (!reg.flags) {
+		if (reg.fd != -1 || !reg.config ||
+		    reg.config_size < offsetof(struct io_uring_opaque_config, __resv0) ||
+		    reg.config_size > PAGE_SIZE)
+			return -EINVAL;
+		ret = copy_struct_from_user(&config, sizeof(config),
+					    u64_to_user_ptr(reg.config), reg.config_size);
+		if (ret)
+			return ret;
+		store = io_opaque_alloc(ctx, &config);
+		if (IS_ERR(store))
+			return PTR_ERR(store);
+	} else {
 		return -EINVAL;
-	ret = copy_struct_from_user(&config, sizeof(config),
-				    u64_to_user_ptr(reg.config), reg.config_size);
-	if (ret)
-		return ret;
-	store = io_opaque_alloc(ctx, &config);
-	if (IS_ERR(store))
-		return PTR_ERR(store);
+	}
 	ret = xa_alloc(&ctx->opaque_stores, &id, store, xa_limit_31b, GFP_KERNEL);
 	if (ret)
 		goto put_store;
-- 
2.34.1

