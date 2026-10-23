Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714647;
	b=rHmv4D5f5PHe/PC+J+30JUciKdEZyMS1Zxg2BNh+6F85miVS26p678qqQ34THvTTV5Tu
	 3Ay7cKyG5AIFvcg6MMP27DLg7geNPCXLsomH/u/EU4CJpr+OFBayB+hV8CmrVenUZQpUe
	 nEbuE50ORlP4+HEmPU9Vi/GNQ43uICd5WjNrpPf30pBTY9/FuHP7TGUnYJV8ncXl6CQzH
	 b3XeDWf2/HSXzzZHh3auBn8puc7D0e+xjZzAHZcUWJ7VDY0EGzjdpt7E66EtYTvUs5oDc
	 eMsoy9qYQK65KO9HTaq/+1DZIR1O9pcICOVaErYzvtVrY28y/dbOJJCuNEMOGThONrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=oBYxcbD5svbaTalp54IT3TgPIj7U31fwSGEAMAykp6g=;
	b=TOxxof2qdPbXx3f09siU9YLYMF2OwWx+Bw/2RQFtNlcPqm3QmOmcunRy4pwFTTffuu49
	 bq4KHwI66eKi5EWpk/H8CrOtQPFpcxL8jYOLxGulBUe5rnclwSHHuSUvoc5QOGR8pjipS
	 EnUMhDjI2VNaD3zxu+CpsYVFy7YVFl/h6TswqQUHDfLkt6AqeZQQhOVZk2t9QYSC/E3Ty
	 ONgkznsDWfciQfNgdQ6iD6xHj0wwhrG14mtIw1xQC4ZLu5JL+lsTGJZvuFaPt7hyFhcKy
	 Mosg1VAdamndsoEWBbcD1vJhqg2Us7yvUpSiQRB1hNrt8NHVtYV+9FOO4dWze3hXdgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Uzdjs9XQ;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EFB606A325
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2EFB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Uzdjs9XQ
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-151ba226e1bso743024c88.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792714646; x=1793319446; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBYxcbD5svbaTalp54IT3TgPIj7U31fwSGEAMAykp6g=;
        b=Uzdjs9XQVOgnkMzwfBYWvjzVPffgDZiQPHuB7ca4I04DBEfMxl+SZG2cJaTPfFOhwN
         t+g5y1oKjg1juaBKzo9njVVZJwP1DJtyBkRQhBQXvBsLQXvF6LgBncxC7JQJr0vDXhqi
         CP+7nNAOsooUIFkJ0iptaqUyOkBz2hNfRdjSz3rpEsqCnLeLg8kxvKWrxsIoAJdogkmB
         YPBpTk4CFBJKy6jXMT3L+7yw5RplJVA6nAlT+WJPWHicaHslH4es3yLeBG+O8C+XiPme
         h0pgfg4n0lRqt+1SwqQjKxolYOTGP0Wh3MRm5Hl8ntmbsGJ7Tz94WD2BVli+bR96kugY
         DEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714646; x=1793319446;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBYxcbD5svbaTalp54IT3TgPIj7U31fwSGEAMAykp6g=;
        b=tND2Z9CzexNgknqqYhL2I8GS8J3Qf00U9yWQEkohwv3P8AuopOtFlH8suG8C4a/Cpz
         djMrDHdZLPA7jJPfssfQHpXTsZoN1e0MBxDSI+EoXkP8b1aRTa1ZtmyyA4QL5ZG77LBD
         8Ke5j+7ymboln2Tp+pw4iH2cP+PEDjb6sMWU7aGYLiK2xG9YDi/meXB459+mtAvDvK1D
         aBQ6NXCVkmR1eC6zlP277T44bP2DwwPmAfww64lPXx3kCqpICOq7QM6i9zJs5Vd+po2j
         awYb31VczejhE/qyf7c8Iz9a1M3pLAf2bIGKYBzr3XMXwys3S2ZFRWJRaOwM0Kt13380
         IIDg==
X-Forwarded-Encrypted: i=1; AKwUvByeWtf5dEty5syalWfM6POEmkLtDExsQAcd2RAyfWqof16R0F7xw4Icpnk96EgkKjT5aKY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSH3oCWfM56f2PM1giuqbwZU0mBBq05Bge0x0V4rNTzXtw6jON
	esgN2oyeSMUx50fU3EwkwjsUv0sO64OqdTu49SdX12nWZ4nHB5pjT8KDVdsGFsfglhsuu+gbCBm
	8rdkJFAvhnp141w==
X-Received: from dlbps4.prod.google.com ([2002:a05:7023:884:b0:191:327b:5758])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:4184:b0:16c:ff3a:d72e with SMTP id a92af1059eb24-195c6b29320mr1346079c88.20.1792714645130;
 Thu, 22 Oct 2026 17:17:25 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:16:03 -0700
In-Reply-To: <20261023001603.560210-8-wusamuel@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023001603.560210-10-wusamuel@google.com>
Subject: [PATCH bpf-next v2 2/6] tools: Copy KALLSYMS_QUERY definitions to linux/fs.h
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Copy the KALLSYMS_QUERY ioctl definitions from include/uapi/linux/fs.h
to tools/include/uapi/linux/fs.h for libbpf and the proc and bpf
selftests. Only the new definitions are copied; other differences
between the two headers are left alone.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 tools/include/uapi/linux/fs.h | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index f0a26309b6d5..d224516e6d6e 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -567,4 +567,45 @@ struct procmap_query {
 	__u64 build_id_addr;		/* in */
 };
 
+/* /proc/kallsyms ioctl */
+#define KALLSYMS_QUERY	_IOWR(PROCFS_IOCTL_MAGIC, 18, struct kallsyms_query)
+
+/* Exactly one query mode must be set in query_flags. */
+enum kallsyms_query_flags {
+	/*
+	 * Look up a symbol in vmlinux or loaded modules (vmlinux first; BPF
+	 * and ftrace symbols are not searched) by exact NUL-terminated name
+	 * at sym_name_addr and return sym_addr. sym_addr and sym_name_size
+	 * must be 0 on input.
+	 */
+	KALLSYMS_QUERY_BY_SYMBOL = 0x01,
+	/*
+	 * Look up the symbol covering sym_addr and write its NUL-terminated
+	 * name to the sym_name_addr buffer of sym_name_size bytes. The same
+	 * symbols as %pS are searched: vmlinux, loaded modules, BPF JIT
+	 * images, and freed module init functions still tracked by ftrace.
+	 * A buffer of KSYM_NAME_LEN (512 at the time of writing) bytes is
+	 * always enough. On success, sym_name_size is set to the number of
+	 * bytes written (including the terminating NUL).
+	 */
+	KALLSYMS_QUERY_BY_ADDR = 0x02,
+};
+
+/*
+ * Returns -ENOENT if no symbol matches, -EADDRNOTAVAIL if the name maps to
+ * more than one address, -ENAMETOOLONG if the name does not fit in
+ * KSYM_NAME_LEN (512 at the time of writing) or sym_name_size bytes, and
+ * -EPERM if kallsyms addresses are hidden from the opener of /proc/kallsyms
+ * (e.g. kptr_restrict).
+ */
+struct kallsyms_query {
+	__u64 size;		/* in - struct size for compatibility */
+	__u64 query_flags;	/* in - query mode (enum kallsyms_query_flags) */
+	__u64 sym_name_addr;	/* in - address of symbol name buffer */
+	__u64 sym_addr;		/* out (BY_SYMBOL) / in (BY_ADDR) */
+	__u64 sym_name_size;	/* in/out - name buffer size / bytes written */
+};
+
+#define KALLSYMS_QUERY_SIZE_VER0	40 /* sizeof first published struct */
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.56.0.257.gf7497c7d27-goog

