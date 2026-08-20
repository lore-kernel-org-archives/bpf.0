Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A5449B17
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231923; cv=none; b=YWkj7YAsfO0Udp04erugRgUd81CLtLm8Zf2dvVtmxwNtn8jk4bqrduJAzuiIclfnlfAMnjPOweJcQQnfy3A/5C84Ojf7fD3DVGbhs63xeRsoDfRN/0fqwPgIQrf+cu+4GpgBi1esMwTOAV7fw3foygSdZMz9GMr73E/pRal9ddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231923; c=relaxed/simple;
	bh=B2fucAtdhxsImTUAGZWjue4CaG9TwF8/ytvWhAOak1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRUHgb3yxqjpYVwjJxOB2X8nZFlfYtE/QZZuAfW5Jtji/a1PuY0rf8en++lXiECrHxsZ9GpgfHGe+/UeyYk/uBVtehsMU2QBnX9T/Wzl1WUDLz+NoLPAM4utxzJvAvT7qADdXCtsDKW9UZGHe6l9HjYh+VldoHqHx7KCZz0FzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnnW2LK6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnnW2LK6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49557167508so23122225e9.1
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787231918; x=1787836718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d/dzYche3n13dnE4ECcGdXysT5dUdq4Uh980G2RdpPA=;
        b=SnnW2LK6X04KPLB43BPAdE50px/DsktrZGQv28Rbm/D9hpv56ie965uLNyVs32s31v
         2QvCsSXjs1vFmKcPDwKn3f4klDreOjO14QLSJqr2o35Btyqpj/aM89kSRjbwGoCnL2AK
         xU6ZXAYpm9ZfJ7IwM8BxApq+4eFChJlncBQPY9X27EEjTObE5vev5yVuKq4c68MFKJp4
         76g09XAp8gjMSSrrUbY1VDfXRI4rQx6rqLSBRNahJwRUaNulTl2C4qt+QQpHKVk77sDN
         kLC1b4dxVyNlhvolyFOmZHv6Fe6i8hGOK/wVjlWHdUkQHnHT+ML2EHXVeY3GrNANoIWR
         f5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787231918; x=1787836718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d/dzYche3n13dnE4ECcGdXysT5dUdq4Uh980G2RdpPA=;
        b=qrQJlYbCk6D61VdWXJ5ZMoUIApZq3dwJxdEe1+CughOjzB9+tEL5vNHV3LNw3VXV2B
         AGncgNe678P1I1ZemgQ/SJC1NFNjODZpnhiuiSi0gSsaJEYHkDlZKxsRg2JJqeClmfkL
         WxeEYJnQaXvN8t//+aeeCoDDFf3ze2lbMIw1+wekyxl8LKJb+fudU5JAtpLnDPyXbRGj
         Ykqxqv7f9IMBJEYXBx5Iu1geiItRztMU7pTNvkBm9RJFzVpT2GYVUCvCLhD0eFliKe6I
         geKt0EVPhyNlu2vGqseAxoA8hecOKI1knojTSPE5qfNPyK/c2NIkWFG/cE8YbK+rk9UV
         9lcw==
X-Gm-Message-State: AOJu0YyV8+CRA4s//wRV1UEiai9Zt/6lcsMyj744OeRNUsJikhjS7tej
	Kef+ZimUscYvIQUe5lP61/DZ8AoDWHjqPxwsqICI3BVtZW5feNNG1UQc/4NxKXX8Eys=
X-Gm-Gg: AR+sD11+voHppb+h4at/MBBK6d/BgJkDi0NyejoUVj+HMnR0h/KLTRZK9V7ho/vIBnK
	CSe2a3Huxjx4ohzEBdCAQSyyoKyJRprmXF36qn7ggh/BnWSPjruyYakEnKgIAcQEz+MXbB3BOKM
	MRSa6SMg1edtviRrDChprUuYiVb/khOj/MJSLPKEgAdVC5jU3Qkvza9WND1zL5ZnTPB8HZIvHaa
	+/JSB9qjypZ67k+XJlOQN3wo9MTMUGojeDTNmAWC+NuAbvZU4DHHS7wviUBrgTkxOphhjAnSZYM
	zxE0D0veeHkRGecD6BTtIkBDFDSC4buRJzgAayk2kAinv2sdnl6S8DG/KdPoafySbMok5ZvHcmB
	LSL4Vh4wajQ6hQqsZ4AH3f3nD5RiMoA9dysBAiu3ARSVkpab83qMEFAQuejpLiHpjQykdTWNY2O
	2KyL8oBjZ0ezluUJx0/I/9t7gsZH2Y/PIRv+xelIUAkfvSAxkFzyt2Qt1L2B4fX+VHdHf2j9H8e
	4D83K4/oQ==
X-Received: by 2002:a05:600c:6749:b0:495:6274:56c2 with SMTP id 5b1f17b1804b1-499aa1896f1mr232088665e9.2.1787231917285;
        Thu, 20 Aug 2026 06:18:37 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0e473dsm136027275e9.15.2026.08.20.06.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:18:36 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	utilityemal77@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v2 1/3] mm: Add copy_remote_mm_str()
Date: Thu, 20 Aug 2026 16:17:59 +0300
Message-ID: <20260820131801.68759-2-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820131801.68759-1-tasos.papagiannnis@gmail.com>
References: <20260820131801.68759-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copy_remote_vm_str() gets the target address space from a struct
task_struct. This does not work for an address space that exists but is
not yet associated with a task_struct, such as the mm held by struct
linux_binprm during exec.

Add copy_remote_mm_str(), which operates directly on a struct mm_struct.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 26 +++++++++++++++++++++++++-
 mm/nommu.c         | 26 +++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..eede435bf4a3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3222,6 +3222,8 @@ extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 
 #ifdef CONFIG_BPF_SYSCALL
+extern int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+			      void *buf, int len, unsigned int gup_flags);
 extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 			      void *buf, int len, unsigned int gup_flags);
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 6b8280cfc1db..da0010c4475d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7218,6 +7218,30 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 	return buf - old_buf;
 }
 
+/**
+ * copy_remote_mm_str - copy a string from a remote address space.
+ * @mm:	the remote address space
+ * @addr:	start address to read from
+ * @buf:	destination buffer
+ * @len:	number of bytes to copy
+ * @gup_flags:	flags modifying lookup behaviour
+ *
+ * The caller must hold a reference on @mm.
+ *
+ * Return: number of bytes copied from @addr (source) to @buf (destination),
+ * not including the trailing NUL. If @len is zero, return 0 without accessing
+ * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
+ * -EFAULT.
+ */
+int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+		       void *buf, int len, unsigned int gup_flags)
+{
+	if (unlikely(len == 0))
+		return 0;
+
+	return __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
+}
+
 /**
  * copy_remote_vm_str - copy a string from another process's address space.
  * @tsk:	the task of the target address space
@@ -7247,7 +7271,7 @@ int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 		return -EFAULT;
 	}
 
-	ret = __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
+	ret = copy_remote_mm_str(mm, addr, buf, len, gup_flags);
 
 	mmput(mm);
 
diff --git a/mm/nommu.c b/mm/nommu.c
index ed3934bc2de4..1fca0bb7f042 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1752,6 +1752,30 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 	return ret;
 }
 
+/**
+ * copy_remote_mm_str - copy a string from a remote address space.
+ * @mm:         the remote address space
+ * @addr:       start address to read from
+ * @buf:        destination buffer
+ * @len:        number of bytes to copy
+ * @gup_flags:  flags modifying lookup behaviour (unused)
+ *
+ * The caller must hold a reference on @mm.
+ *
+ * Return: number of bytes copied from @addr (source) to @buf (destination),
+ * not including the trailing NUL. If @len is zero, return 0 without accessing
+ * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
+ * -EFAULT.
+ */
+int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+		       void *buf, int len, unsigned int gup_flags)
+{
+	if (unlikely(len == 0))
+		return 0;
+
+	return __copy_remote_vm_str(mm, addr, buf, len);
+}
+
 /**
  * copy_remote_vm_str - copy a string from another process's address space.
  * @tsk:	the task of the target address space
@@ -1781,7 +1805,7 @@ int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
 		return -EFAULT;
 	}
 
-	ret = __copy_remote_vm_str(mm, addr, buf, len);
+	ret = copy_remote_mm_str(mm, addr, buf, len, gup_flags);
 
 	mmput(mm);
 
-- 
2.55.0

