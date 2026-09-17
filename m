Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348C14E9C32
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675568; cv=none; b=lVWu1gD6Rvp8Qut/JN8Eva8PThDFup/sO1rh7f1FXhzWfaNcT3Rg59+g3pyniyoeCMRmVckko2EL3m+4vLSXnEkD6afJPdWcFyi8GuRdKWGFnb4WIPvcFxVrcFlw2wAYGIxKaIGL7A1TM2v6ESKUO5Ip27X6xs8BeqpVi86/EFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675568; c=relaxed/simple;
	bh=Ya5PIcZgMLo2zklquipUX7Ltx7iCIZIiOZeby4s8p9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKKB1CsINGw7GCtv/0/AZdj8vFnXevDnb+hPNkHIdz6spTUR9UiSNNrAlmiHzHi7eS+s7XPGDFw4MkZttcjKj8MxFXK8T5HSm6wNTX95t6ualyw6h4H4oUYXZhoaha0r3NPLmnu4zoNYkdtcCyqgv7jJ4oIVrwqqv+2m2OtRvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R14WPr2/; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R14WPr2/"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae6b1b26so566810eaf.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675561; x=1790280361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DvySyAC5XHW/JX+ir/isD+KikFZqdRSkNS9adXYgc40=;
        b=R14WPr2/iWYdRJDQbWsdnRAA1EjliM5PTEVBiFBpW6SUyoCNFJftmCGK1O4eg2eRmb
         mlEOO27TTnQRbG8Qz+fnPUhDWxdG8uqfSU/wocyDkVp/1DfJt8jlw2lKKMtn5t/snYiY
         I7NHNDAiWB9SMHsp5XIstQb5tGcLe7C5p8/87bc52J2NaQv0IK8fy6YQYB0fzp9q1E85
         NLxpIl+ozUV7/XBSH/ADVgCLteLYvhjBjD5HS5S+zGJNyU6AdVzVYgmKmZh2EvLmqi74
         +tlLEHL978/0yVseWBuHfnhtS6MbitUikyV2BLkPoJm6x7mbIB0DXCgMdvecK4bXRJqQ
         pVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675561; x=1790280361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DvySyAC5XHW/JX+ir/isD+KikFZqdRSkNS9adXYgc40=;
        b=Coz2fliQwBe6//Y8b8MDjEhSa7xhmFF9M5+F0Es9tCM9J1k2gjhTReqb/VHygmbV0I
         Mu8Gx+XJDqIbKTNh5l+gBKMdkNsIczOTVx7dHNo3yIYs9SxW9xLe+E+KqeUAPNIu74CB
         7cpaHNXg4w8ZQD7OV6YHf6BWDIzJiKC7dyiJizDX8vRf+HLhfJ+wO05/JUrsmHHlGUyE
         CaxYzxJfaHSxAKucdyWvLwnEShPkjcIG2re0RQzdZPOIC4TbLXZKXb8hEFfXyJekUF6s
         /SXf3kZela3O7nnnEaLHhFKOX6hosWBfnc5EbezvqDttoa8UoZsWmGw+uHirseurp5R/
         i3tA==
X-Gm-Message-State: AFuF++kAw3v99A7tAFr/elGzrNhnVeRM7FuzjK2Uo8iXs8K5EsWq34v/
	BMxC5BJgym7lCbLhqVOfYHScz0RadIMh9tjZhNENJQjFCSYgqxfeSt1BVlSJhQ==
X-Gm-Gg: AYBFou26PQB9Kw0D8dcnOigIaf28BB31VuiLD/IfZcllML2Jlsj5dTjQcw514Al0ZEr
	ix3Xd1CYYv4tqkZXRKhwjKTYlUubB7e6CBc7IK12VVauDdn/z2z9SYZ/TXCHP6OOpr0M1V3ii9r
	gzAXsM3HU8GekyD3PHH92v31aq3owkzCPOrXdc8PGSI8YlX3PYh4Mo2t5aGA0LGO2Q/hbVSBJQk
	Nuy7tv/D9dm7OfNiT7nPiYV5rRmsAXUnz4+BqXqp1z8hN94hRCmDiE3n/cGN8ltwtN0r4TjlubR
	7Vk85zGZv8zcJsMCj14ZphBDikD6d9CbuLdz4uIKxjfsYLZsh5SwcPzdSG7V8chIrmJU8+pQkmv
	3uhL49NesV4QIcpkxI0S6oc7Et89zUTglkY8LnDA9pFM60F7NQnaba/pL3xuBtqcEK6u50IBAZs
	nVIbjr+gN3nBLP/l6uHJGCeCuU9jWhSzQ7UjWR8w/nIF+6NNgk77mHpLzTTbEyKW/NrU9lMAPKG
	g==
X-Received: by 2002:a05:6820:2915:b0:6b7:46fa:16af with SMTP id 006d021491bc7-6ca9d14e709mr70263eaf.68.1789675560669;
        Thu, 17 Sep 2026 13:06:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c8f72801f2sm4144401eaf.11.2026.09.17.13.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:05:59 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 07/15] bpf: Move LSM trampoline unlink into bpf_cgroup_link_auto_detach()
Date: Thu, 17 Sep 2026 13:05:33 -0700
Message-ID: <20260917200542.3689605-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917200542.3689605-1-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

Move the LSM trampoline unlink into bpf_cgroup_link_auto_detach().
The purpose is to consolidate the auto_detach cleanup logic.

It prepares for the upcoming struct_ops cgroup attachment patch where
bpf_cgroup_link_auto_detach() will need to handle the struct_ops case
(link->map != NULL).

This is a no-op change.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index bced8e20fa6d..0ce58764caae 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -313,6 +313,8 @@ static void bpf_cgroup_storages_link(struct bpf_cgroup_storage *storages[],
  */
 static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
 {
+	if (link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
+		bpf_trampoline_unlink_cgroup_shim(link->link.prog);
 	cgroup_put(link->cgroup);
 	link->cgroup = NULL;
 }
@@ -346,11 +348,8 @@ static void cgroup_bpf_release(struct work_struct *work)
 					bpf_trampoline_unlink_cgroup_shim(pl->prog);
 				bpf_prog_put(pl->prog);
 			}
-			if (pl->link) {
-				if (pl->link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
-					bpf_trampoline_unlink_cgroup_shim(pl->link->link.prog);
+			if (pl->link)
 				bpf_cgroup_link_auto_detach(pl->link);
-			}
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key[atype]);
 		}
-- 
2.52.0

