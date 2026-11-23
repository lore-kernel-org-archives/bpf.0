Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438152;
	b=rXzIlzo5R7K8PFWjgz30QgsoMHXV+lCMtkqd8WjKmxc2kDM51Ylfa5TzAsDChC8sf7OM
	 mxeqyk5FGqnMxDvok2a1FzPduw5J16+4QSmK3d51/IvvSBMivJ1khfuYV8fdjFZMdMeMr
	 yLXwv4L0eb7FbxBbWKm5lyMo7vVJvwI3uTU/QIPqwbDLVGFmG0U5MtzQVKLql5tT2RFSe
	 0neML+REahbli1SuYS9t52gryfnt1tphDZZB5yQjFOrFPbe6AC9z/9RyqPgtulzLNEdw5
	 5oW86aQKmUISpQ+FQeHnGDMYGm2Q3bJ7B71oN6ikQs6MCt7zfIL+GPGWhTzU5NNUJ0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tsppM5r9P8IDAZvF9tVeal/ifxUJ2bPVFRohpx39xuM=;
	b=yGhpQRT/ex/Rr5LjNy7zfIXThT/7Lv2ThM9AG9Io/beRj9EPs1g/EF0ARK7aJfIIkELy
	 SbK8CxtGykVBYP5sX0PxPbk2HOsqTf4wriWZnTIu5soL1IF2+mX+7vJBHft2PTRYEB8ze
	 qQLUIl1GDU3+O9kjOKAbNPomEEDMafvVpqAD+//yEkLIHdLhjG2VRqNU7AE47O7xWHNlT
	 7yLsKaYl0lzsKdilQEi9RrhsO43Dw3SdEoJbXc5A0qikIFzU9ro51AFxWDNtDvfue0V0Z
	 Me0nCUc80z1A8aaekcqOvG7OsGZcT4fd6EcRada54D+YD/mtlkTD4FVYfqI6qmtqqOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRSb+ieZ;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419F606A31F
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 12:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2419F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRSb+ieZ
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so24737435e9.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795438150; x=1796042950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsppM5r9P8IDAZvF9tVeal/ifxUJ2bPVFRohpx39xuM=;
        b=HRSb+ieZAHicV0bivaU64IiEiatkKaFIFWyiv7B6A4XjlUEfExYhH0hcBR0IxceoAu
         dAl25ourv9e15p4IFDqCmeHLcvynrdxA6AdKXBEB0IRvmv7uYg+GOQxho7BROmBQv9zU
         nMgmEaQ0j3XFIzs6nuYabWjj7SeZQmkXfR5BbvJUl7j+LZDuD5h6JanPMROLnKO17uOb
         iKY3EMiKz/StTFlGhrRLmOE992MpZDPzGHxi+MAzLJzStfYxmWqLlzyRmY4zrM0jNnvt
         C77BYMQPsoJqeWLHcfKVCW/mUyzmtZ3mQsBYmZ6nFD4z9mTf9RyMMKio/65eqI6Puft2
         QD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438150; x=1796042950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tsppM5r9P8IDAZvF9tVeal/ifxUJ2bPVFRohpx39xuM=;
        b=BfXR2YXfnRO1raohkPhGry43Ze1BKCMaVYtRVilnn28RTY+HTmKKYCB8+kILshZ1gk
         DS3XNSfTmRT+Kl3+exoVaHdJZZU9i/ObeBxodrnKyMt2lVyopR4mq+4WO50Gpogi/gCo
         EyAp/ZUbKl0PX3iCz2nRjNhrfA7XlJyuW4vgwLJsFtYMjnuQvzkeWLt7hPnT9SaUHpIQ
         qyfUm8D5QCjiqBcWxGbzQqzWUK3vznP2+sLdzVY20NGSrEIDBFQYTCiqKxvTZinXTDPV
         91kCuNS89twdmrxmMbuczx4srn5p+Vl7/LESx9nWBWYIVGIOUGQ+snLco4yA1xQVgEAR
         n9bQ==
X-Forwarded-Encrypted: i=1; AL+hErGd5295Sb73/+7g7vfH9Wl/KzBR2nbt60Q0qG9RqcLF5ZYd/Q6vz/Fys9n7HZ8ZRm4mFCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sd5VQDkCkkNZVHjLTyWbxv4r+07Bg8FAoAgNtRn4aIStqt34v
	3JUD4Ma93RvYKdW3nfdM2cRyXhUqYDtu8Aszb5NeYOrNFrxQaxwawuKM
X-Gm-Gg: AZFdTZctly2gJlkTJ6aS+r+T5KkmIyjKbGNxjymhRMPX8ONL/ADCAgjKwlBB+Ld5cfE
	KVkuNOrD7pkp+nMoh9QWcWnhlQoHG3269tPeEx4IM/JYUXklqMkzriSdXlpHML7/ias0OknoCCY
	5nSVIPZv38FR8Ynt6A4t/TZ4S03LxHobnPRMLDyeoI/9p57ELnCCDV7rR+GzIGVzbNodHTP2Rig
	8CLyh8QCdtmYgvTXWldI+7achfHakjS3nkZH1Fxty1Dg7bxLi045xdnQ9SYefUzro1gQrgQD6Y1
	MgReh2iMez28RvpuAPUmgFO3BIvBFBoKaVMcsxsJQ/5Qt96g71fUhQqqsODazIpBKmCT4eVYXuB
	BmmqREeEv/n8C3ubKazv1S9ILwHi21XK17pmXOSPVXaKua2GVWEaht/mnHsf4Im0p1YyXQMDksM
	2RHfMgqcEAcZb0n/cJlGzmpbw+p6csjJuxYrVWJKFdtjwT+l4mPQuZQroElRhQzmkFTO0q2kaT8
	KbgWlh5RvICGVL4+6YdRuSzTFXUw413lqb3grTBnW/w95aSc+FYMvziJQEJwV2bEuWNbwM/9Jda
	qDjCpzQf9YjzlMD4EO2iGiYmMHj2BUgNUfR+ENc=
X-Received: by 2002:a05:600c:4f16:b0:4a2:47:b79c with SMTP id 5b1f17b1804b1-4bb8882a66emr266500605e9.32.1795438150370;
        Mon, 23 Nov 2026 04:49:10 -0800 (PST)
Received: from Philipp-PC ([91.227.186.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm165097045e9.5.2026.11.23.04.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:49:10 -0800 (PST)
From: Philipp Sudakas <filzador@gmail.com>
To: ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	u9012063@gmail.com,
	Philipp Sudakas <filzador@gmail.com>
Subject: [PATCH net v2 2/5] vmxnet3: keep the previous XDP program when attaching fails
Date: Mon, 23 Nov 2026 15:48:52 +0300
Message-ID: <20261123124855.1021-3-filzador@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.4
In-Reply-To: <20261123124855.1021-1-filzador@gmail.com>
References: <20261123124855.1021-1-filzador@gmail.com>
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

vmxnet3_xdp_set() publishes the new program and drops its reference to
the old one before it recreates the rx queues and reactivates the
device. If vmxnet3_rq_create_all() or vmxnet3_activate_dev() then
fails, it returns an error without rolling back. dev_xdp_install()
treats the error as "nothing changed": it drops the reference it took
for the new program and keeps the old program recorded as attached.

The driver is then left with the new program, to which it holds no
reference, and without the reference to the old program, which the
core still considers attached. So far this was mostly hidden because
every error path of vmxnet3_activate_dev() goes through
vmxnet3_rq_cleanup_all(), which also clears xdp_bpf_prog.

Release the old program only after the device is active again, and on
failure restore it, together with the redirect target feature.

The problem was found and analysed, and this patch drafted, with the
help of an AI coding assistant. It was also reported by an automated
review of an earlier version of this series.

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Philipp Sudakas <filzador@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_xdp.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
index 5f47049..45259b2 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -66,11 +66,9 @@ vmxnet3_xdp_set(struct net_device *netdev, struct netdev_bpf *bpf,
 		vmxnet3_quiesce_dev(adapter);
 
 	vmxnet3_xdp_exchange_program(adapter, new_bpf_prog);
-	if (old_bpf_prog)
-		bpf_prog_put(old_bpf_prog);
 
 	if (!running || !need_update)
-		return 0;
+		goto out;
 
 	if (new_bpf_prog)
 		xdp_features_set_redirect_target(netdev, false);
@@ -84,17 +82,31 @@ vmxnet3_xdp_set(struct net_device *netdev, struct netdev_bpf *bpf,
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "failed to re-create rx queues for XDP.");
-		return -EOPNOTSUPP;
+		goto err_restore;
 	}
 	err = vmxnet3_activate_dev(adapter);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "failed to activate device for XDP.");
-		return -EOPNOTSUPP;
+		goto err_restore;
 	}
 	clear_bit(VMXNET3_STATE_BIT_RESETTING, &adapter->state);
 
+out:
+	if (old_bpf_prog)
+		bpf_prog_put(old_bpf_prog);
 	return 0;
+
+err_restore:
+	/* On error the core drops its reference to the new program and
+	 * keeps the old one attached: the driver must keep the old one.
+	 */
+	vmxnet3_xdp_exchange_program(adapter, old_bpf_prog);
+	if (old_bpf_prog)
+		xdp_features_set_redirect_target(netdev, false);
+	else
+		xdp_features_clear_redirect_target(netdev);
+	return -EOPNOTSUPP;
 }
 
 /* This is the main xdp call used by kernel to set/unset eBPF program. */
-- 
2.47.3

