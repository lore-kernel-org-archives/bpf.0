Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627625;
	b=Ng28LaC7PRetVTzlXSh6lTYkQzdkXv0zAq21kiv4WW8k/wQzXElHLHQ7J4PRjLoNOGdM
	 QcCndpYwtf0i8vPX5n+qL2hPsPRLicpfBPmxaTusYvzxT8McgIaYexDg9FYLbnhnQLhmS
	 v4/HDKwSmWf1BVgXe2ASFX6Wx4u2AQdasXh//VaNrRCi8DtZ0oWAfedeFipbD1+/zW8EN
	 uK1JjEEumXgd57nw/jvZELFtXGhgZbURxHWypRbjRKdqthrv5OCOzOPVCfgNqywl6LlEf
	 KJpjTCb2UA9cssV4RBn5LEUmDtodumwCCI0IF20HQVFWHgdSzJK5QEjk9UHzGR14NYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vhJPPbPPep/NKmBM2GPQOvhuWsdva5kFxdCaYldPz6E=;
	b=xWeJKub2zlqxubhjtRq7m75pYLD4fyGmwP2Nv3zQ+jSkqZE/eK3540C+AHo5KNLRENpZ
	 lxwjfvpyMkfFC0o5ZNdMOMeHSymRDZ3lXU8TvsguxWP7n+0IhXQ9Yd9IV9h7J/dZiQN+C
	 +49vQkvCyDc6S0kSYowbZAcsbUHAqk/rNiluiUUUiEcoSVl5H1G3LjXSEIcEFOdpcgTV3
	 ZUwjBgcmbu/3F8gxTTvT6435gSbbmRVPY6ql9FZDjVhgj7mPHHCQm4n721aQl38bwY6Lr
	 w2c+GqMiOs30o0XlXNAGHvWbSAnEb8aoXRI2VxHo7ttKmYc4AKCnGfOehlUP3s7rJqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E9lD7E8Y;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8A5606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 00:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C8A5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E9lD7E8Y
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-181516de561so123223c88.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792627624; x=1793232424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vhJPPbPPep/NKmBM2GPQOvhuWsdva5kFxdCaYldPz6E=;
        b=E9lD7E8YjxMrfVvlvWjYpq3oi0EZtltjY8BnOgR7wkv4lXoK1Ejrqp2YiigLPwLhl5
         ldfSn6zAUVyKraxNNN2aiEou+n8KTcfW6Tk1YwPGfzddO3FnOMuhc2l9UQPq1W0T52OC
         n4GVZAjZbi5JDoVGP2Zsq36/0VuEaDH49u3iEmZRqbm2SS+FaOaOuCrRgvWmCzc2A5VO
         zK01huMZDuBcUn9vlT3yQTf2NRUlzzmon0+OxOxisA3pUNMQM/p2X25nOIatKsTeHG9t
         8sQ1M/px4bVh0y+mefbdBMuFLj6/gEDejzawa2vw0MGj4V7m467P4c03npQUPx/4uUdN
         Jy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627624; x=1793232424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vhJPPbPPep/NKmBM2GPQOvhuWsdva5kFxdCaYldPz6E=;
        b=amlWAzeboZUoqJIpp+bOHTMRRjHf88KgDUPQh/nLmaSonNMyzDC33U4Jn/kMjj3xfS
         DZffJg5vJhj5LJqF3tuGSE7/CKChl0U22j5YNAgZi0HvehxynGh+SJaAm3K514F/lZcL
         l3hMNxkcyUpQJxun5NnUaGQ1N0ML/Uacea8KtarF92Ov6jwFPDLoh7h1oBPf/275gt+5
         ZsHQV14DrRIZYNUFwjPMYV3+xasdOjkaYSZRRldFwFx95dkNFXUupajxkFBzY5EO0TGc
         02Za+ZuijwSRPzCKAqMbPlmAOGBC1gAafwu1NoCvEEKsRJnlbkH0iddXsbXpwXn8N7dm
         6oUQ==
X-Gm-Message-State: AFq9FYJfTvLFmD0ZC4XA9A7Ewilomb8Us6NI63dOYbkStcR/+8/1AK+V
	EC76TVufe1BKAeJvvqDdDlXlKOcJ8C6GrtKswjAU3icVFGq1Fik3CQFkJ3gmohkpqw==
X-Gm-Gg: AYBFou1uy2THh3ipKnn5VOy+ADzcm3KFul2G9bY/UMKnCNIIGK53vQVVS2R5yUMnreV
	AdtKyT6VgK/3JE5IHk47u9wQFqGVLgFKsVmR3uWqvrxty8ZhGzjUFOPWtiTiopTacymDage0iV/
	8scAseDj7fQqY2+/IHCOknQR4dFfRZrNTVCQbsVzpGISJPgK2l1pxANbs4/XirVlL2fyMeIUmVh
	gfJGBpimKHvpIiCoqVGkWy/AgeMrmAH+VMeCsRB+QrZ5a1LO24J51UBw5Yidhceie0uH1MfDvud
	MgWJLUgaBf02Ck4Sw3Q9da7KCxHeKazDZRXULFRdc55yaeP4aHfpsJydBkCIHL4d4Zfpf5pnlIA
	qiMVhwUcoX9zwPL7x0iGKbkWIPZ4aqn20vDoZxe9M59ByHBapZtn4qPKHsWYpOLZkxz9j9ZgTms
	osGDDJfV+TFSDoHYKxh0F06+KVNA4W678h8VPlE8Iz9r261Hu5my4lMbkyu0Ap1LZWRUk9dCc0V
	3FYPGpYCbLzZ/e8LPxEyEF/UzRgBIIFoYUIoHVJ6+80Tb/fYmjnE4pXMtJ83GLnqw==
X-Received: by 2002:a05:7023:905:b0:184:60dc:c381 with SMTP id a92af1059eb24-192f113b4c6mr1168163c88.23.1792627623993;
        Wed, 21 Oct 2026 17:07:03 -0700 (PDT)
Received: from localhost.localdomain ([185.220.238.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1902f96dc4bsm10682022c88.0.2026.10.21.17.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 17:07:03 -0700 (PDT)
From: Wang Yibo <szwyb123@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next 1/3] bpf: report kfunc sets that fail BTF sanity check
Date: Thu, 22 Oct 2026 08:07:00 +0800
Message-Id: <20261022080500.100-2-szwyb123@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022080500.100-1-szwyb123@gmail.com>
References: <20261022080500.100-1-szwyb123@gmail.com>
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

register_btf_kfunc_id_set() returns -EINVAL when a kfunc in the set has
no valid FUNC/FUNC_PROTO pair in the BTF of the registering object, but
nothing is logged: the caller (typically a module init function)
propagates the error, insmod fails with -EINVAL and dmesg stays silent.
The only hint is a warning from resolve_btfids at build time, which is
easy to miss.

This happened with bpf_testmod built by pahole 1.30: that version does
not encode __int128, so the three i128 test kfuncs had no BTF func
entries, their ids in the set stayed 0 and loading the module failed
with -22, with nothing printed to dmesg.

Log the offending kfunc id, the object that owns the BTF and the error
code when the sanity check fails.

Signed-off-by: Wang Yibo <szwyb123@gmail.com>
---
 kernel/bpf/btf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 538129ed2..af07206f9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -10128,8 +10128,12 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 	for (i = 0; i < kset->set->cnt; i++) {
 		ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id),
 					     kset->set->pairs[i].flags);
-		if (ret)
+		if (ret) {
+			pr_err("register_btf_kfunc_id_set: kfunc id %u in BTF of %s failed sanity check, ret %d\n",
+			       kset->set->pairs[i].id,
+			       kset->owner ? kset->owner->name : "vmlinux", ret);
 			goto err_out;
+		}
 	}
 
 	ret = btf_populate_kfunc_set(btf, hook, kset);
-- 
2.51.0
