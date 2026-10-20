Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508216;
	b=U4gM0hF72h+06NdCf4aATSpGD14kuvpFvwiZsNUU8whAvXMcX6lKeS2/huelKo3aXDfS
	 +EZHRLKzilmPKcaxR969yB7Kw7oKQ/zKdAxmTOYDeciuUuvxGCyWxA6iUHYyJDC0+rcsf
	 t4d737Vz1S6P4H+rvv21qvCcSySfdpCAhemKkMPYRsYsEXvE183XZm2v5QjE0Lzl1iujK
	 s3omy69HGZAFTvxyNgcD4fQiA7fKDn2SIDmTD2YUOaZOZy3/cLv7WJBogTPvj1EZ4Rv8s
	 96o5wfIYev2vZfCw9XgMjN1b+8RL5mlPDU9j54oP5PwOXvK4RAVZpnqJi3rd4m88XGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HcC9I3HM8PkvM9oYwYIQQHE7BTWNOlfs5NQCIXXB490=;
	b=o3G8YULjSxMoncYYinDclXhOj/M5ujkSeJAesXCsBgpB7CU5M056twI27g+/OiToCag9
	 SNf5yc09DT1nSymKhQ5XvamB/x/avulQkeUy3b+XPTbtjteHjZeMRsddKkv3B6AgP5FIC
	 3BA0lnO0dnYBr9eNAcb0aCVD37bhP0CUlEVOi4GYYIV8AeVaziHw+Y+bZe43VjVdLMwjy
	 hqFOo3p2CCrBlG8F6PaeNkxhzFZml0YnPrNHqXwFnKsBh8KujJo9pPI/oqgmH0Krp0eQe
	 taGs7UdNekeiCt+fvF4qgUx5y4HtMhIAAzCC6BpAV8u6OOcX7o2Kfrwu0F6fC+TCHNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LuShPugs;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B89606A323
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B89606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LuShPugs
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66fca0709caso2698438d50.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508215; x=1793113015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HcC9I3HM8PkvM9oYwYIQQHE7BTWNOlfs5NQCIXXB490=;
        b=LuShPugswmZJP7u4GV/OxkTrGHwqMHPXtwVV3YYPTlt5swJAgBhFxPyD5nWw002Gl2
         kQChuBgaqbAItlKCXBrxVB1ELbLRYDqDFhxGAmbzBVDlpeM1PdmkEqAD0MmVQx++Znhy
         TJ8Cl1nABpZI8eCtpqaWOUd5rjm8d+Q7zmH/dOqeAU6nN1EI2vBj9VE44FJVB15V/mi6
         WH5VYGAFLZTiwspzx/lzvd4/izHn1bRmXBMJ6jnjNezyiQxb5Pjr3+oH2FE85sMe0ttp
         cVVUKjlnbli96aNUTnF6dQtM/FP3Jyz+SQpKSSKJ9Ze2Gn0GOJqhyXPIWDMlH6rB8Ffz
         c1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508215; x=1793113015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HcC9I3HM8PkvM9oYwYIQQHE7BTWNOlfs5NQCIXXB490=;
        b=VLQa7CGo/lmycV/V+0T8KWpdGzYV90K0S9ZiJc1yiBTOGa+/HyuAxGZsfXsYyKw48k
         +Pky+6ibqIcI5htdwY+F8Lur0ipwgqJHA0YtFbf+QFB0X7EYOvfzNyQpPAjEnXNuZQJk
         IXDW6sA1gcv9QYif9pInFAn4k87DVMkrTLV/XEzKzDB8y6J7zjHPRXRHtPXrHi+JnOsd
         W1nlXN7/0ecUAly/zZnip/3/D+ayNVeHrzbVdgyWt3zTIKtV/v9EDD2S6N0y/pJYFbY7
         QiAWjM7p4ZO/EXbpIotUaNFRGY/+vLxsHfq3wH6j0yddE2N8azgYITezVgqCa0Pypac7
         ltGg==
X-Forwarded-Encrypted: i=1; AKwUvBzL2i3uuGj7v3d6st0ixqBG8nXY2N5eeLBkFjv/2rQbMvRCmGWtKK5xPDrqJpO78q++Hzk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIA0v8DZT0UWUtbvfp8ZQpxbGgdH3YiUyrazcTwzt0NgFxaG/sh
	EO9hyWcBpPLylIgurTbFlho4t21JCs1NbUZAfVZzZauPWKr52ZRU2TWE
X-Gm-Gg: AYBFou03PReWL37hvVzZYeY3jmrX6kFhqb82+dJl4YEwVQ0jV7LHk/V1wXUuMOHNrmQ
	kVbiE5Ly7UHGY/NI/7NtzxkAfVoHcOb3CYxxPLKqmreD53/tBMzP8zkbiUhMjujOwq29rGMbGyx
	aUHnoZqMwa0p/9LE6UWccMMtIeikIEiXrpT3WhbZFKaibVb27OMvyJsohbtCITJOjTBPM7JwAfJ
	vv10UUWUWHnRfZPv5Z6RhQblfxFBFoYBSYSKIjUtZEuU5KcLmKk0BuPAH/juJ+zSQgdkLruR/3d
	WnOEgHze1YlNgqTZi/yuTUy6cI1St7crttc8/65DXq9O/P9dtLTXy0rzLRuJk1inPmsrKtLzXhG
	JwkRgWwp+qxoxdGtZOtIHGqGujnRYYeFOK864PKIaJLgD4X5x0wJF0j2Izanxl4qcMogdU6Rw7N
	tKJlx1sMGjaAyDTZasM7w4Uv4FMS99njSah0qgl1AGChfD4hwZ3Wjdfg5+bh6+zPVmIWHDbjOrs
	8T08ayXgQ==
X-Received: by 2002:a05:690e:b47:b0:67a:a:a5b6 with SMTP id 956f58d0204a3-67a000ac7d4mr614715d50.33.1792508214680;
        Tue, 20 Oct 2026 07:56:54 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8701:205:573e:17eb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1c98a1esm5239944d50.1.2026.10.20.07.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:56:54 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf-next v2 5/6] bpf: Bind iterator elements to their iterator
Date: Tue, 20 Oct 2026 10:50:58 -0400
Message-ID: <20261020145059.2146170-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020145059.2146170-1-utilityemal77@gmail.com>
References: <20261020145059.2146170-1-utilityemal77@gmail.com>
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

An element returned by an iterator's next() kfunc is kept alive by the
iterator alone. bpf_iter_task_vma_next() returns a snapshot that lives
in the iterator's own allocation and holds the vma's vm_file reference
only until the next step or destroy; bpf_iter_kmem_cache_next() and
bpf_iter_dmabuf_next() hand out objects whose reference the iterator
drops the same way. The verifier marks every such element PTR_TRUSTED
with nothing tying it to the iterator, so a pointer saved across
bpf_iter_<type>_destroy() stays fully trusted after the memory or the
reference behind it is gone:

	bpf_iter_task_vma_new(&it, task, 0);
	vma = bpf_iter_task_vma_next(&it);
	file = vma->vm_file;			/* __safe_trusted_or_null */
	bpf_iter_task_vma_destroy(&it);		/* frees snapshot, fput() */
	start = vma->vm_start;			/* vma, file still trusted */

Set the element's parent_id to the iterator's reference id, as is
already done for the PTR_TO_MEM elements of bpf_iter_num_next(), so
that destroying the iterator invalidates the element together with
every trusted field acquired from it. Elements of an RCU-protected
iterator keep MEM_RCU and stay bounded by the critical section instead:
they point at RCU-managed objects rather than iterator state.

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/bpf/bpf_iterators.rst |  6 +++++-
 kernel/bpf/verifier.c               | 13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 189e3ec1c6c8..08c9c15b59ac 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -79,7 +79,11 @@ Constructor/next/destructor implementation contract is as follows:
     will eventually return NULL when elements are exhausted. Once NULL is
     returned, subsequent next calls *should keep returning NULL*. Next method
     is marked with KF_ITER_NEXT (and should also have KF_RET_NULL as
-    NULL-returning kfunc, of course).
+    NULL-returning kfunc, of course). An element is only guaranteed to be
+    valid until the iterator is destroyed, so the verifier invalidates it,
+    and every trusted pointer derived from it, at `bpf_iter_<type>_destroy()`.
+    Elements of an RCU-protected iterator (see KF_RCU_PROTECTED) are instead
+    valid until the end of the RCU critical section.
 
   - destructor, `bpf_iter_<type>_destroy()`, is always called once. Even if
     constructor failed or next returned nothing.  Destructor frees up any
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c85c83a6ee63..9ce5517dc1a0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15504,6 +15504,19 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].type = type;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
+
+			/*
+			 * A trusted element is pinned by the iterator that
+			 * produced it and dies with it, like the memory
+			 * returned by bpf_iter_num_next() above. An RCU
+			 * element is bounded by the critical section instead.
+			 */
+			if (bpf_is_iter_next_kfunc(&meta) && (type & PTR_TRUSTED)) {
+				err = validate_ref_obj(env, &meta.ref_obj);
+				if (err)
+					return err;
+				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
+			}
 		}
 
 		if (is_kfunc_ret_null(&meta)) {
-- 
2.55.0

