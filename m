Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792619630;
	b=G9kSjHZD0Km+YfFJ1wmd23vbJhAq77zOULYHnlz5AFUUWFUV7WwOzZfLQtyhBd3AOxbp
	 gN5RYPvfA42RU+7Bgrn6+KL1DrNCP1FIgc3bo1qencPkL0nvFVMdoV/zlKoi8XvxzwPHP
	 PVI5DXjorpj2zxz3G2jE5XMZHhUFGbS8Ft9WcixIS7htgA2epPWJ15IuTloCKijPa9snV
	 4+GhWxya3X8mAYer0qfu5/WYZuKKjRt1EwAURgIZjXEM3ZlQe6w6rJyW7u3P1SoLNg+Vc
	 JdLrbHg5xv3cehsfpXJCr0CWMOak5NjIyD5jNDlPzmcQeTCWbt8OPOUlPYO09qD87mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792619630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mtRYkql7bK2+Mk9/MALlnk6mIy+nScSi0K/oMYikPEc=;
	b=UCVLwftMjhXbguDywhouVvZATATObJWoAI3kTAX9MkjO/zt/5EZARlu7e9LDQIBil7g7
	 A/5kCi8TuHLqASrbqrMFnjGzLrFYgiFBGutfdids+vd2lccVoVehclgIhWc3fgHm72Egv
	 B/yqrXLp92iqVmIzOuzFEQE4hKfTLAhqfIhC1l/coqVcY0RMtoaufMUSVgw3kJHlmUPIB
	 D0sMmuH7JS0O1eCMFFyhwm0wom1PkPqQA1c4pA9IyKUEfwowDKFkYaQA3zZBhn+TdLANO
	 AzJ3AiqySolmYnvK7ITWMgqHf6EJPsznzZ52ocRmYUBFE1r0vs1eS0DdTn43tA/2myg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cABGdqYX;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC62606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 21:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC62606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cABGdqYX
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-886e61fa30fso470202b3a.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 14:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792619629; x=1793224429; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mtRYkql7bK2+Mk9/MALlnk6mIy+nScSi0K/oMYikPEc=;
        b=cABGdqYXLXx8C1dXRIFghvRXabpseERl/6fM5pwK9rlZJ0CDtP7XcqxjX5rhdjN9oG
         PgSJ2CG+brNc0eJ3ZS88V+KI557oM6Vby9VxtU1iYqcDPxSb7rzHnI1jhNK3Vdc17g0o
         chiHwnlFACfHEtI1kStEfTT+jOZhaGxcPKp/YyWBX521mz1cD4Mw6byR2kiQJPu9gy+T
         ruBPg8JzZUxnxzxKh7smiRKRIHsPjn0sw2y3GuaC+KzIljAMx6hDP7FgQ5nWvioLxik1
         +l8g5MbVCZ6kz81pfc7g8FDM0F7SFyXUxn33KS2h2sySEUtfk6Ja9Y49cg7V8415aq+3
         gfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792619629; x=1793224429;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtRYkql7bK2+Mk9/MALlnk6mIy+nScSi0K/oMYikPEc=;
        b=WVsDnoWsCBs6OCr9J6gk4donSh7sjyD+ZtKBf7xPEDRBJASpYGq/PQ+0kYt/OO7K0s
         nLBWpAtQfSw7AU4Uv9O47TZWyermoBiTaF0SObRU5aSt+C0Yld/vilAQ4yBhTpekg9vD
         dg9Tn7tx77/dZesQzONGGzG09sranUP5JVXUvVZGXB+mVj7cEzTQIy0r84k9XQsTvC9e
         myQybaLvxCee2aUxJzuwUI71fywGehASF/eJxSCFSxII/y6kh1TzZblSz6wHpSze8Nwp
         HthatiUDtjpSPtcpppzeJBkI3my+tbkFRp8cPKAdGZ8Z8qa1jwde/yPun6d6+YQ46i1k
         n7dw==
X-Gm-Message-State: AFq9FYKSStSkf2nYST4Ix0rdw52xsFQcHKnDaaTzYZSwt8oOmkBZaUpR
	y++jlN3oFwlPkMxfcWXEUxvhV/pjmPZ4TM2pxB8r6lYUstMmG5WeTZco
X-Gm-Gg: AYBFou0Ds7X3DsoLFSgKM3MRX8xN0l6F6sb5uTMjxRw6htExounOtDajZOxqrlfKFwr
	Kaytyr5HdzR0hxwdwZmOSNF7QQAjX7nhct0KCoFbJJc3koAIcO/85OUNFXGDH5G77ysWV2ZR84D
	7wUIGPklPbYo4CGRd4XdMEK8eZslnkkp0v+6bSDmpvWXnT5JVqPnQJ95QCk+6h37P32XQAVHBce
	aQDVEq6E0aLWOqS2KnMQfz3t5pXhks/KkbC699ZVBEOIMEXVWd3NfUl32+/H5wixfJy5LZUYLq8
	2UpA1C7a5TOCKiemE01nft1nNQoXyCjx4JzN8gQ50KL49R+Mqo8cNjxkpf6xpKkbySYicXB/PSR
	a29rgBfTFoy1R8+AL8rOyUaX4Yxn5aQYH+8Tg+uB9mNpdq/m/wicS6+pD/ydpEp4PGr+dLrPNWl
	UWjRMBypRky+seNy1s5gR0J9wgl9z22fimUfhjmHwy8BuDXySCXcTUdBQtcyQsUa0MEjoGEU1TL
	rTYtGCkL72rtqToUfxKv8DmkfHa7iUcg2MUiZ2L1MTkWhE5Wv6KaFEsPvlQf+unUSBdllCDDUWb
	7BLuwGD5+mUEr3DL7jF+BOG/uhDiqr51Im/4SMMeLPrb11ggI/S4/02U3Grmkg==
X-Received: by 2002:a05:6a21:4ea3:b0:3e1:885f:b4ab with SMTP id adf61e73a8af0-3e287bca4bbmr2324254637.8.1792619629160;
        Wed, 21 Oct 2026 14:53:49 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895f8ca3sm1297288b3a.46.2026.10.21.14.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 14:53:48 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 21:53:47 +0000
Message-Id: <DMAUMG9WL4X6.12UEJJMJSW54Z@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <linux-mm@kvack.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>, <linux-kselftest@vger.kernel.org>,
 "Shuah Khan" <shuah@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>
Subject: Re: [RFC bpf-next 0/9] bpf: Add support to allocate user page
In-Reply-To: <20261021195759.119421-1-jolsa@kernel.org>
References: <20261021195759.119421-1-jolsa@kernel.org>
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

On Wed, Oct 21, 2026 at 12:57 PM Jiri Olsa <jolsa@kernel.org> wrote:
> hi,
> we have few use cases where having the ability to allocate normal
> or executable user space memory would help (like to replace function
> in live process or change environment variables)

I think it's better to do what debuggers do:
vm_mmap() with the final prot and
access_process_vm(FOLL_FORCE | FOLL_WRITE), like PTRACE_POKETEXT,
to fill it. It faults the pages in, writes into r-x private mapping
and copy_to_user_page() takes care of icache.
Then no need for bpf_user_page_exec(), do_mprotect_pkey_locked(),
the marker, READ_IMPLIES_EXEC special case, get_user_pages(), etc.
No mm changes.

Like:

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1..ca1d88d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -29,6 +29,7 @@
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
+#include <linux/mman.h>

 #include "../../lib/kstrtox.h"

@@ -3834,6 +3835,60 @@ __bpf_kfunc int bpf_copy_from_user_task_str(void *dst, u32 dst__sz,
 	return ret;
 }

+/**
+ * bpf_copy_to_user_task() - Copy data to a task's address space
+ * @unsafe_ptr__ign: Destination address in the task's address space
+ * @src:             Source address, in kernel space
+ * @src__sz:         Number of bytes to copy
+ * @tsk:             The task whose address space will be used
+ * @flags:           Reserved for future use; must be zero
+ *
+ * Faults in the destination and writes the way ptrace(PTRACE_POKETEXT) does:
+ * a private mapping doesn't have to be writable.
+ *
+ * Return: 0 on success, -EINVAL if @flags is non-zero, or -EFAULT if the copy
+ * fails or is partial.
+ */
+__bpf_kfunc int bpf_copy_to_user_task(void __user *unsafe_ptr__ign, const void *src,
+				      u32 src__sz, struct task_struct *tsk, u64 flags)
+{
+	int ret;
+
+	if (unlikely(flags))
+		return -EINVAL;
+
+	if (unlikely(!src__sz))
+		return 0;
+
+	ret = access_process_vm(tsk, (unsigned long)unsafe_ptr__ign, (void *)src,
+				src__sz, FOLL_FORCE | FOLL_WRITE);
+	return ret == src__sz ? 0 : -EFAULT;
+}
+
+/**
+ * bpf_user_mmap() - Map private anonymous memory into the current process
+ * @len:  Length of the mapping
+ * @prot: PROT_* flags of mmap(2)
+ *
+ * Return: The address of the mapping on success, or a negative error code.
+ */
+__bpf_kfunc long bpf_user_mmap(unsigned long len, unsigned long prot)
+{
+	return vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0);
+}
+
+/**
+ * bpf_user_munmap() - Unmap a range of addresses of the current process
+ * @addr: Start of the range
+ * @len:  Length of the range
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+__bpf_kfunc int bpf_user_munmap(unsigned long addr, unsigned long len)
+{
+	return vm_munmap(addr, len);
+}
+
 /* Keep unsigned long in prototype so that kfunc is usable when emitted to
  * vmlinux.h in BPF programs directly, but note that while in BPF prog, the
  * unsigned long always points to 8-byte region on stack, the kernel may only
@@ -5139,6 +5194,25 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 	.set   = &generic_btf_ids,
 };

+BTF_KFUNCS_START(user_mem_btf_ids)
+BTF_ID_FLAGS(func, bpf_copy_to_user_task, KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_user_mmap, KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_user_munmap, KF_SLEEPABLE | KF_PERFMON)
+BTF_KFUNCS_END(user_mem_btf_ids)
+
+static int user_mem_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&user_mem_btf_ids, kfunc_id))
+		return 0;
+	return security_locked_down(LOCKDOWN_BPF_WRITE_USER);
+}
+
+static const struct btf_kfunc_id_set user_mem_kfunc_set = {
+	.owner  = THIS_MODULE,
+	.set    = &user_mem_btf_ids,
+	.filter = user_mem_kfunc_filter,
+};
+
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release_dtor)
@@ -5266,6 +5340,8 @@ static int __init kfunc_init(void)
 	};

 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
+	/* Sleepable kprobe prog can only be attached to uprobe */
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &user_mem_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);

But I'm not at all sure that it's a good idea
to inject code into a process.

pw-bot: cr
