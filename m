Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612955;
	b=AC2UfipT4jdDv40J7lsOvaZrmBEs75gXQIgV4XeX2mTjXyuXMGFd0vlYFMZ58a2KE/jD
	 bw1pFU+UjMbolPgqK+wwIID6kp3Jr+c0lGUmEyNcErcyB+zh939zZjdaz8EnpWcv0e4+q
	 tmCdZfvuvs5vMjYYB321cEChx3cRM5npg4w7DGkxoxf/Oa4SPBEg/9yTkXdvuHApLR31K
	 SCxD+Y2uG7/ntmVzbx/N+F0axn/nKUTVDLOrCKeMFBTeazygi3eqZ/9k72LWRvr1NdjUY
	 7hvwWJesWkEQeMjG8idn5/xuzTz5qfy63QbiXuafRUGAexOUJ3wiylldLLGWfmrY4Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=DVsHyMGpZ63VlMQMFc2l9guiKac3vrIG640jy3Z5XHM=;
	b=AUemA+h9QaZdPdLoFYICh0TGT1YS3pRjb55Gj+IMcuhFj0y/h5aIU6WWIl4jnzzvDSCI
	 JzMAvz+vXKf4FYB+fnm9VOxtvT7GJL8+zcsqsa1I5MJU29jrsJuF4vmILn1dN4am3Ma8E
	 243DShypEu2yLWMmu4Bdxl6x9bFMgmqGw0gY9rN3gqK57Dxd3ghBF33pb7liWYiCUY+Va
	 dfrB+SWHOtBw5Na+E01fDMxkTmKyYxpRWTUmRleiwUoIBZpbE74tgivHsgaVjC4neoFqZ
	 vAdVgqSUK9HQdPoXmVvCooqPm+U0t02gpwE8t3tZPURI92sVIpcN3hE7ST0NCOfPcxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=paeGkoLO;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31382606A686
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31382606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=paeGkoLO
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490d59c3edaso3931334f8f.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612953; x=1796217753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DVsHyMGpZ63VlMQMFc2l9guiKac3vrIG640jy3Z5XHM=;
        b=paeGkoLONjJT3YQjnE/1B+om2jGmEANtwlVZF0O8G0eWI0XaXv+2tY5vAuuBq4/7AJ
         gKTpE0L1sgw5H+/RVe8zHQ9p7Oze4Im11rvDz+GIPA0rCtbGNLBjY74gmLPNg0ytD6jG
         lE5p+JF4geCbr6UM4uaRGsORDtwyhGUrik+1cPo/2egNGc5aaJuCdTbKJiO94lZp+YEn
         KfDe1HrEqRnVA2enzTQZlqnAHT1ufy6zl1PSQQpQlqjcXFKzBKi9U9QbEdjvjYqDL5RR
         9PqqA+mCJz++ySWVhODcjGB092bgVRdxVT3lOEnb9XG1Jgd4pWiyFcg6QS9bHF/2lTSi
         lRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612953; x=1796217753;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVsHyMGpZ63VlMQMFc2l9guiKac3vrIG640jy3Z5XHM=;
        b=X4uWrPJx2XUTdRwf05wN77PPyveSicgg1yVmn278uLM8f+BRRj9Q++7wKszNVpjVfJ
         iYbM25B+RLa9S5BKrjTPPr5ctjhXFJZqN/VUR8gNEiZwXhzrErvXMNn5yf5SWwCbPfjn
         5dquHS8KYhYMeku4S7agck1FBepWuH2yif+TJ0cD3sGwRUhevVJH9weK20pdWfImhYDB
         4DyJ8dzmhmYYiL2f2/DMcdA1z2Z2fj+WAg8GT9YDog7B51WCe76Azlr01nX4PaMjjCFH
         oUXJyA/1Z4QUbycPAs5ecSMTqEbNcpLYibJ40XY5sP8xcLqEZ+GKtmQLFWHA3dsS+Y8D
         qCug==
X-Forwarded-Encrypted: i=1; AL+hErGkJ3uPz6Zrb0XWVkbl0nmLjBCuRH1wobkZQyzatX8g3WOquR5Tymq6BfFydyrM5AEJ2WQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oRTX+KasFtA/TulPR++pIdfT4XtxEIHcUCBsIwxh5Z5YwKp8u
	E6uBvjNYw6XoURkoX4iNfAIp2ezi1+Gf/DnsxBQOA+eAWTicJLPHXwz7+vh3QA==
X-Gm-Gg: AZFdTZdmtMSmW8ZHDzZt4wrqWPhcGk1VpnfMGTTArCKzduk8CoNybXfcw3uG+xeuXQa
	xSENR68UZU+zOX5Lu/ZOqvt8kSfY6MqM8tntgEkyTKIVdOEh8zzokCpmZ7xlFvumh5oURl7ZvQU
	OerFUxVPjtRBq+l+TjO3cEK5rrVwS9UVmUhklO2SA+PqLyprfBR83FS4Q89Bpvt1DRgSKDtR9Tm
	OdAvCH8mhnO3gXbtA7liktZjnB7eXxz2wPmjHsSE058aT40D8v21zd/g8hQYgfrufto2VpafTZv
	/uZ07WvNtf1dD3oq32wyjp6MkXrnP8Fh60zRGxIcrru6hVCshrdgFd3Sq/9YPTu3sy/PG8x0FUx
	qiI59Gwym2QLQWFFHDmNkEBt7GdFEDEl8x5duF/fzOUjx/cFez1a/oNpHYNu3+p3KkCZLRYPCBS
	h1NuD/+Z/IWMKSb2+5YQGWIxvxT8D+uG8gQzkUoKwnXB9ESlSBSa/gs6x8zWoHA+N7+Ei47FiSG
	ECbE5oGDFMKMHDZsa4zmwTWq35ZEBusxDrWcj9Lj2JW6sCdFhWL+2QBF41y0F2xHosDa34tSHGb
	4Ku8xzCdTFmXsfiZR9BHNzUlWJ2/srIx+I9tavw=
X-Received: by 2002:a05:6000:4028:b0:4b7:6dcb:e909 with SMTP id ffacd0b85a97d-4b76dcbeaa9mr10415299f8f.8.1795612953303;
        Wed, 25 Nov 2026 05:22:33 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm33352706f8f.47.2026.11.25.05.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:22:32 -0800 (PST)
Date: Wed, 25 Nov 2026 13:34:12 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 4/7] selftests/bpf: Test fmod_ret on a
 declared function that returns a pointer
Message-ID: <awbj1OVca5Ep-wuN@mail.gmail.com>
References: <20261125102810.699464-1-a.s.protopopov@gmail.com>
 <20261125102810.699464-5-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125102810.699464-5-a.s.protopopov@gmail.com>

On 26/11/25 10:28AM, Anton Protopopov wrote:
> Add bpf_testmod_modify_return_ptr() to the error injection list.
> Check that a program on it may return an error pointer but not
> another value, and that an extension of a global function of such a
> program loads.

Once the https://lore.kernel.org/bpf/20261125032938.670542-1-alexei.starovoitov@gmail.com/
series loads this selftest will fail. So I will send v2 later. Just
in case, the new patch is (after removing freplace piece):

selftests/bpf: Test fmod_ret on a declared function that returns a pointer

Add bpf_testmod_modify_return_ptr() to the error injection list.
Check that a program on it may return an error pointer but not
another value.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
index 2417030f104a..91f810319e87 100644
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include "modify_return.skel.h"
 #include "modify_return_width.skel.h"
+#include "modify_return_ptr.skel.h"
 
 #define LOWER(x) ((x) & 0xffff)
 #define UPPER(x) ((x) >> 16)
@@ -144,3 +145,9 @@ void test_modify_return_graph(void)
 out:
 	ASSERT_OK(rmdir(instance), "rmdir");
 }
+
+/* NULL or an error from a declared function that returns a pointer */
+void test_modify_return_ptr(void)
+{
+	RUN_TESTS(modify_return_ptr);
+}
diff --git a/tools/testing/selftests/bpf/progs/err.h b/tools/testing/selftests/bpf/progs/err.h
index 38529779a236..be3100752d35 100644
--- a/tools/testing/selftests/bpf/progs/err.h
+++ b/tools/testing/selftests/bpf/progs/err.h
@@ -25,4 +25,9 @@ static inline long PTR_ERR(const void *ptr)
 	return (long) ptr;
 }
 
+static inline void *ERR_PTR(long error)
+{
+	return (void *) error;
+}
+
 #endif /* __ERR_H__ */
diff --git a/tools/testing/selftests/bpf/progs/modify_return_ptr.c b/tools/testing/selftests/bpf/progs/modify_return_ptr.c
new file mode 100644
index 000000000000..dfc6f0185caf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/modify_return_ptr.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "err.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fmod_ret/bpf_testmod_modify_return_ptr")
+__load_if_JITed()
+__success
+void *BPF_PROG(error)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+SEC("fmod_ret/bpf_testmod_modify_return_ptr")
+__failure __msg("should have been in [-4095, 0]")
+void *BPF_PROG(not_an_error)
+{
+	return (void *)1;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 1fbc0061cc24..73d5992cc17a 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -774,6 +774,13 @@ noinline bool bpf_testmod_modify_return_bool(void)
 }
 ALLOW_ERROR_INJECTION(bpf_testmod_modify_return_bool, TRUE);
 
+noinline void *bpf_testmod_modify_return_ptr(void)
+{
+	asm volatile ("");
+	return NULL;
+}
+ALLOW_ERROR_INJECTION(bpf_testmod_modify_return_ptr, ERRNO);
+
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 		      const struct bin_attribute *bin_attr,

