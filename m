Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616457;
	b=bKFXP9nX47JWLGnyhca9vtVybAxzKwwpqmKcepmYsUBJT7Hh2ECAuhnfbxe2OqYLjxAJ
	 JCldL8yPkZSKxQUiJ+9zPbjqDyFZeK+X7MjaMg/Gtg6ZTsmkTWfI9c4lv5AQ9J7alVWzu
	 ZVGZPv2FuQM3E6CfacF0m5LqhY4zZ98YFwa/B5YtH49dvOSB4v6IiJVRdWNvaO67j1dYJ
	 kCG2IU3g2GWHDk6HnP7qXhX4HoW1YSIAoXQH+WXYeKjYzHVdECQH+XAwOmBCE+USfxSTu
	 OVLNGXuLMYdIlhYT69etwQnXlK4GQXSMLrku3WbPXH1rfs377rAz4pdtssGPIDve6Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fgtT2+a9TrTITBRXB1pk27WkIgQ+nxQrQ3NB1J1hYuM=;
	b=34LCL3HW7h2aqWu2SG6VVsD5BvaLsI9K4K6hkc/jH7GOodjLd6bqj7uJ7CdMj3VzqVVo
	 aoEWOqll5F814NNuCwwqnCTTa7zfiKjgsQQfM4SB7vgBGF4ehvEkVv5hIU7Oeeu7rgGnB
	 /bBrPmqE6PHU+eHNtTkfE2czRLXSmfgp5FRJKPaKrQeNjvz1qbs/IONxFTVA7GyIPsF1G
	 EzWUkBEHN/pH5rcr3namig6RNrH1txcfidAFpbDqtTnYGBE2SzoRlF0HncTlRdGEuJ3/D
	 od4LRikglpHId/ggQIEch30vze+Y+AaVof1U20ed4k6L//CTH3mG481zVMxAdcdzEKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KfoU/C5V";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D66606A33D
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 10:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3D66606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KfoU/C5V
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a214af2076so21273145e9.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 02:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793616455; x=1794221255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fgtT2+a9TrTITBRXB1pk27WkIgQ+nxQrQ3NB1J1hYuM=;
        b=KfoU/C5VTwLgglWwOGIhOu2WjOGvxbM3LY2fCfJz6lShfFpPvqzy4ezwM/iMiYgL+q
         Tul9qsTFt++Vxvo5bj+KuUneF0k5khy7EkUtw3aga+Z2wW4RYU6YE8GJuraORD8x08S/
         aQtEf14PxG1LdsFtNKFgAq/Lpj2k0gGfugTqfojHwT01jomsA0iz3y0RfDCao2L/qmfm
         65mIOVntxKNAxTZzjP9b1wIthVOejEPTuUOOjULlkmuMz9/xT40F6sutVETL1s64XQqg
         0PPGjTllaw1G2DtC88d9PLKw6sF1RjF4k0+wdB5iPssFkdXmYpzHNeklTP2rebzN2zi1
         rHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616455; x=1794221255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fgtT2+a9TrTITBRXB1pk27WkIgQ+nxQrQ3NB1J1hYuM=;
        b=OFv0bpMYyyzsUSEUHpEEhESTYFsdfvcZzrBMKPrlM/vEP+EGTBAVcrCvBSyNNzFq8d
         4AlAsK8sT0tYhTCkB77EHvkLXV4G+izNUpFDJKhrcxQ6UeeZ3kid7BhQjkqIsobtjrQV
         8Uxgj9sbr5r/hs8Wf5QQSMrmE/BybGayHhiib9+f1WTw5RtofPdkjfHOfgX6GPzPdN2v
         93eSlAae6OmGRPOTZRKDm0eoBxBmra/6zjXmqHo/lBYSxirXzr2+JxsRqO6jJYaIUq3y
         gBPLuNYlDs4RnmiL2s8jL+gni9sUkemPF9I1oPusqxDWV7q7Vqx0prI0TXoq7r1NjjUe
         3VpA==
X-Gm-Message-State: AFq9FYJKhtlOVqrRdnM2PEmE2G9/Bhwc41p/oVYJDSE7vatBTXVjt517
	NJr8Ef2TEKKQgH3PTH/Z/3GtU68+UsCHkPZYxM/jUp/4XsaqqJG18rjP
X-Gm-Gg: AYBFou1ey+vBYJbCf1QOdEwzLA7pQgeAQzBDP2GFAf9tjUpTDkVMqSKTD05CC+K99cO
	WH53wxPbTC5uAqp4wlmYWlqpHdkgQXqsqbRj+AG3WZvRKUUTu0sIX61oZOV11/GjBuXRYCBa8AD
	ohF7HWV65pvbFEVe8EAZdLmbkAexlUXr4iLsnJz06Z8XvVrwihu7FMt453su9xPXeeNCQp9tlPC
	19l2EJzWojFkJLG60i+Fqdy1PCBIlqFSypjkoWBLYtu2jvYC/TqZQxXr1Fd22kl+wWrHGdIzd89
	d3lKKl6QMDnwm67Jr/5x/oXrLVkILaKZNbgA5kVJaE51k3qBUJknXdwmD7aWEIGeTwx0Lc8MAi5
	RYkp1WE9iIQk5Y1oGikIu0l2lqpbZ6sJvye9BlV1T/s93aTfIekD3jcD4bOq2DlU/YwgmLhGaP/
	O3BatmfuwNPr0g/SwG/te07Rk3Vwk5Zvcl+Qigxet9clabMX5CBmfTzpReimT8Bd6tfE+ryVjju
	kKbCoxKmGV2BSpfJzm8RfiYMd/yw32cXeyhdwN9nUdnxSlEq/ybZ1tF8txCkxr5JUwAU852CWtk
	eynxryiLw+hpURplzw5etX2x2IrB8OSOXxoCj8bGfCK1Qvh6uqAaKcHiXYEMm6q7
X-Received: by 2002:a05:600c:6992:b0:4a1:a2c0:7b73 with SMTP id 5b1f17b1804b1-4ac18992c01mr220277725e9.30.1793616454928;
        Mon, 02 Nov 2026 02:47:34 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c7852esm248939695e9.11.2026.11.02.02.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:47:34 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	tasos.papagiannnis@gmail.com
Subject: [PATCH vfs-7.5.bpf v2 1/3] bpf: Add bpf_path_getattr()
Date: Mon,  2 Nov 2026 12:46:53 +0200
Message-ID: <20261102104655.70901-2-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
References: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
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

Direct inode reads can differ from stat() and related system calls,
especially on overlayfs.

Add a sleepable LSM kfunc to query a trusted path and return struct kstat.
Use vfs_getattr_nosec() to avoid calling security_inode_getattr() again.
Limit the copy to the smaller of the buffer and the kernel structure.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 35ccd98a4de6..97afc9659f1a 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -96,6 +96,40 @@ __bpf_kfunc int bpf_path_d_path(const struct path *path, char *buf, size_t buf__
 	return len;
 }
 
+/**
+ * bpf_path_getattr - get the attributes of the supplied path
+ * @path: trusted path to get the attributes of
+ * @request_mask: STATX_* flags of the attributes that the caller wants
+ * @query_flags: AT_STATX_SYNC_AS_STAT, AT_STATX_FORCE_SYNC or AT_STATX_DONT_SYNC
+ * @stat__uninit: buffer to return the attributes in
+ * @stat__sz: size of the supplied buffer
+ *
+ * Ask the filesystem for the attributes of *path*. This is vfs_getattr()
+ * without the call into security_inode_getattr().
+ *
+ * This BPF kfunc may only be called from sleepable BPF LSM programs.
+ *
+ * Copies the smaller of @stat__sz and sizeof(struct kstat). Any remaining
+ * buffer bytes are left untouched. On error, the buffer is unchanged.
+ *
+ * Return: Zero on success or a negative error code.
+ */
+__bpf_kfunc int bpf_path_getattr(const struct path *path, u32 request_mask,
+				 u32 query_flags, struct kstat *stat__uninit,
+				 size_t stat__sz)
+{
+	struct kstat stat;
+	int ret;
+
+	ret = vfs_getattr_nosec(path, &stat, request_mask, query_flags);
+	if (ret)
+		return ret;
+
+	/* struct kstat in the program's vmlinux.h may have a different size. */
+	memcpy(stat__uninit, &stat, min(stat__sz, sizeof(stat)));
+	return 0;
+}
+
 static bool match_security_bpf_prefix(const char *name__str)
 {
 	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
@@ -504,6 +538,7 @@ BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_task_exe_file, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path)
+BTF_ID_FLAGS(func, bpf_path_getattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
@@ -515,8 +550,9 @@ BTF_ID_FLAGS(func, bpf_sock_read_xattr, KF_RCU)
 #endif
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
-/* Side-effecting kfuncs that stay exclusive to LSM programs. */
+/* Kfuncs that stay exclusive to LSM programs. */
 BTF_SET_START(bpf_fs_kfunc_lsm_only_ids)
+BTF_ID(func, bpf_path_getattr)
 BTF_ID(func, bpf_set_dentry_xattr)
 BTF_ID(func, bpf_remove_dentry_xattr)
 BTF_SET_END(bpf_fs_kfunc_lsm_only_ids)
-- 
2.56.0

