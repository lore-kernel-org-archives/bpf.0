Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B0275B1A
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776717258; cv=none; b=ESl2+IDfzpS2Zh5NHjw9GziGV4hN9Cy6ZhJMr8dFj9SBNx4RiD0UXvfOWAgKiIYnun92oHnlgZwiWknJh29W6pOP0h4RdCRNs5Bg1U3XZo85wR3a7XOQNfmK8aul19BFya5+5PzGu+dxeupfIYZ6so77FSkZeh4iHrTT4H3xQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776717258; c=relaxed/simple;
	bh=Uz8hpLu1nmDvYgSHXMdJ0unlL/S3cWb9g1d3BVB+OHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7NeB71Homj9XpSqH6T1nzSjXZpeKhDd98uHbV1upp6rz0u0vnSeMxEiKIzkQ2R37s4AbA7pxRrUeUKwN09Fq0Sx3aXiz28v3Qx4gNcTQul30MPn5DvEHAtebgAY8U6bC51peKCIZSOVqbeItplbkWA5421tnO2BOhdMLffmnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYvNLX1v; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYvNLX1v"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6501725d888so2785968d50.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776717257; x=1777322057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBigbolsro5p/iAF/WdfzlyYllCz/Maz2yDyCMFMbnQ=;
        b=NYvNLX1vU2Kq+hgaUpZt+ufv79IKPqwjr+/lc2gE0SyGeHYRJYf2uFQAKQH34UQ82q
         4qXNihggJx4mZhjFoXD4997UsxN7osqwDbHlNHEj/5oshU14EsNX+miXkKd0J3pmBqla
         KBpWxR3QU3V+3GsV2enJUWHWCNPYgbitRf31JQT6XHz9go1v0UuxDdFRrtLIQD6zHpxF
         4Oz7uwtLdUNJ+YaJx/u75B4Ux1DJHXZ2L9gAnqEnVll418AKd1MkJS+RQVCurOvPw4u8
         QpEf2Tiy4Tqe5gREbAv2UYUVdF805QY78uck8cDSwsVBWmbOir+5iCCS2OtPyYihPhwt
         ql3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776717257; x=1777322057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBigbolsro5p/iAF/WdfzlyYllCz/Maz2yDyCMFMbnQ=;
        b=jhQLow2UI6FffaIcxdpCpZvp3YkipzASaM0GY2rQPRsycimll2AP0eRen+9B0ir0+C
         UBEWzLRjSYiJyjElvGPH5pndAakFMVg+ScRdC0B/qSHJbCyFAnM0TatxtEGFTk64DeYh
         Zg2GyGE0fHIsXUffBaKAESTl4T8i+OCbjfpWY/ikQEZQltGLtYTAtJU7NzvnK05t0BBR
         pIRbLK2nXQzoMdmfg1wks2knA4ZhGKRNzZvI/bEvGo51CUXN+txEU3a/6kXSGeSZBk/C
         TJWIsWGNTIoAnOK+FTJJon5SSbCEfzkkttMd2+H9AwSsVpynFgshPN2gpF31t/wl0ASC
         taRw==
X-Forwarded-Encrypted: i=1; AFNElJ/nheM5N4QcFcxQUV0doR6YEBHTpe4NyJI8lV2L5bLe5EZOAROetAj2KL/lxKVF5LMm90k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyieQB5X6CyQWm1+yiy6KL+2jT7QQXWUjHx8pIxo5bPCCQzfM2D
	iJfS/QtCIagz1bbuDCuHiHg9TYzLBZUc0RSD3A6WeyFe7hhNUDUl0gSR
X-Gm-Gg: AeBDietl0A+cL+4wwX0yS/BmqZ1iUYKNmb/vp1rwKA92JnH9VaynVLCZgHOl+ez3/P+
	36LSOip1QGkCYoiObJjtT/n0jm46/Njgol90TMQXgDJ1hsM7At4XjWHqTr3VNw/keE5kc2IXKm5
	NmN5Icbr6gZYTyZDVWS4gEZCo7T0Kgq5owoSVQbqFRJfiR5d+4wOOIUSdVzhUFVCM6/FI7qX73N
	2eQf7S++ECHJaC8ke9li6U5/c2aY+z8Sb2JKs6bmdMOS9/zFe9r8UyocTlEvtO/Gwqo6cM/UPXx
	oNVlGZbSoyeHez7xukKdFSC/MGZ/Ulgj5EGgBXXIqKSO3TWcT5jyR8T0JE6FJRKF1jxEBhx3Cht
	qN3E0BzJ99Zai1kPZjKE93FvMXgO+Z1EHkstccz0kSquyJeU98boGF/SPPM+QkHj/5ipAx3AcU9
	mWKgttTf4q1ZUJe7PX8+MNov5wlsfkyudRxzgdx/p4ubXmCnxMOY3zBfcQWz0WmDI1kjk36JfrO
	XXBxLuNumlgAXEb2cRdNA==
X-Received: by 2002:a05:690e:488a:b0:651:c53a:ffd9 with SMTP id 956f58d0204a3-65310b30793mr10120630d50.56.1776717256593;
        Mon, 20 Apr 2026 13:34:16 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:adde:1cbf:87f2:a99c])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314e81399sm5702955d50.14.2026.04.20.13.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 13:34:16 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	mic@digikod.net,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Implement dtor for struct file BTF ID
Date: Mon, 20 Apr 2026 16:33:05 -0400
Message-ID: <20260420203306.3107246-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420203306.3107246-1-utilityemal77@gmail.com>
References: <20260420203306.3107246-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a destructor for struct file allowing it to be stored in a map
as a referenced kptr.

This dtor is analogous to bpf_put_file, and calls fput to release the
reference.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/helpers.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index baa12b24bb64..4739e2bf0f31 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -20,6 +20,7 @@
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
 #include <linux/security.h>
+#include <linux/fs.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
@@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void *p)
 }
 CFI_NOSEAL(bpf_task_release_dtor);
 
+__bpf_kfunc void bpf_file_release_dtor(void *file)
+{
+	fput((struct file *)file);
+}
+
+CFI_NOSEAL(bpf_file_release_dtor);
+
 #ifdef CONFIG_CGROUPS
 /**
  * bpf_cgroup_acquire - Acquire a reference to a cgroup. A cgroup acquired by
@@ -4763,6 +4771,8 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release_dtor)
+BTF_ID(struct, file)
+BTF_ID(func, bpf_file_release_dtor)
 #ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
 BTF_ID(func, bpf_cgroup_release_dtor)
@@ -4874,11 +4884,15 @@ static int __init kfunc_init(void)
 			.btf_id       = generic_dtor_ids[0],
 			.kfunc_btf_id = generic_dtor_ids[1]
 		},
-#ifdef CONFIG_CGROUPS
 		{
 			.btf_id       = generic_dtor_ids[2],
 			.kfunc_btf_id = generic_dtor_ids[3]
 		},
+#ifdef CONFIG_CGROUPS
+		{
+			.btf_id       = generic_dtor_ids[4],
+			.kfunc_btf_id = generic_dtor_ids[5]
+		},
 #endif
 	};
 
-- 
2.53.0

