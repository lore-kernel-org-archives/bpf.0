Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0855CDED
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710837; cv=none; b=F2WVjCjnyfTC643QpzvgfJ/oBV48X+W6KstxuMVIi01VZ9uisVVvSs9AkGz+fpS+RQiZur3TxqwI9xzCSEqUHNUS8L9jIYyEgJpkJQFSU7WCm45OEuLrXfSiDe5ynYJhyn/H0DWJg3HUSDL6ve7VcvhgRvqd0TktIono5OvVUjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710837; c=relaxed/simple;
	bh=ddtC+uKArv7UdiqQfjewNtYRkzLuCLfgVvW+TGa7IBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcMSe+u418kOT2Tdroyni9cV9503L2YqdfkTXav1vjXQAK3vtaxn2oMWYhljR/N0yyQPsVtz7VeWaWC9OaWneqgHbSo7LY/RopNn2loplwiaGHVUK/lVLIx+zX+NYJtp8+OKPv3XIU5dHOFWUhfxItLu7rJ1XcObGoh3JRNIfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xyeBSyxq; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xyeBSyxq"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ddca59e336so267485a34.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 23:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709710835; x=1710315635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNwfyies9fK4BVkN1qpRBwPdhTsOnQT/qyn6MGfjNFo=;
        b=xyeBSyxqnFnYSu96xjr+jh7LR1kANzKZclTL/89+Mq9eiLWbe+6VR1ub4GupusB+eW
         Oa1IT7A1R5nckYfRqq6XFdNfdDAS8lPjXCGzbHgkqPz0ZvBbbgSM1Opwr3JF/aJ9Xf3z
         PIcLZnbiXQvVdqhSo3ScBWhwH0udkKt0gcnFpu/ihs5Iuyi6EWJOsmKNrqZ/Y5z1sYGr
         MUcOs6lJUsSz0rTwTK95G43LJHtvkW2nmiwCMVNpevCmL81fC684BNnHcpqe4vreRjgJ
         YpEnruTud1zsYtskWYceqXelRcUBmxhiJHtlX7Zcc5ULsQecp059JiPxDz2ywUpPSEDv
         IyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710835; x=1710315635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNwfyies9fK4BVkN1qpRBwPdhTsOnQT/qyn6MGfjNFo=;
        b=dzrN3mQQ/FI+rX9EZ5ZzTN9anhfSe5OweGUXuVfwLJJN3M2IGZo0pk5EH7a+JcTqa5
         pyjXEInxiop8JZ0rTzCyQlSUqmvHGTPfM/L/if0pCi96Ozh35bYSZc65mFGPuC2CdQBI
         yChYugqsqwCvrS8RBw4TBjhAflf/yzRFskuyGx3UCKJO50PbfNzWoSkyq9ZnjUUwMMd2
         amVQJvg5GE5Ayd+kvTPJLDgNYUz2Y1qb25U85ZwpAomebLCai7pYbjoMNghjFzqxEUZ2
         ShlvDX6dcwSJS27Br//zqU71tMgaKj5i1534TidpqHBbnYVR96Oed8V2sUqp1rGj19Hz
         b7fw==
X-Gm-Message-State: AOJu0YxnDgc6sXJMZuaNLPYufYHOqAjy5nomj+z89v0LbZggQlcTUJph
	mKkfFtSqzCEwphCcZLWxH0lNfuA1J7ay9E2vLTu4wqpPgwbiYgkonjYcSePhbRWIFSd6fZWn7ew
	OpA==
X-Google-Smtp-Source: AGHT+IHSF6r7pWyah8Vo6aI+WZxk3Tmzs3eaCRP+IhPTHK+o4locRRAwnyg28TbdpJHarx1oGzZZ5Q==
X-Received: by 2002:a9d:6d94:0:b0:6e4:ae29:d77f with SMTP id x20-20020a9d6d94000000b006e4ae29d77fmr1908819otp.6.1709710834670;
        Tue, 05 Mar 2024 23:40:34 -0800 (PST)
Received: from google.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id z9-20020a9d7a49000000b006e4b6013ab2sm2183069otm.15.2024.03.05.23.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 23:40:34 -0800 (PST)
Date: Wed, 6 Mar 2024 07:40:27 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 bpf-next 8/9] bpf: add trusted d_path() based BPF kfunc
 bpf_path_d_path()
Message-ID: <af87ec2e92b48a96ca556ec4e62eabde54d509e1.1709675979.git.mattbobrowski@google.com>
References: <cover.1709675979.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709675979.git.mattbobrowski@google.com>

The legacy bpf_d_path() helper did not operate on trusted pointer
arguments, therefore under certain circumstances was susceptible to
memory corruption issues [0]. This new d_path() based BPF kfunc
bpf_path_d_path() makes use of the trusted pointer argument constraint
KF_TRUSTED_ARGS. Making use of the KF_TRUSTED_ARGS constraint will
ensure that d_path() may only be called when and underlying BPF
program holds a stable handle for a given path.

For now, we restrict bpf_path_d_path() to BPF LSM program types, but
this may be relaxed in the future.

Notably, we are consciously not retroactively enforcing the
KF_TRUSTED_ARGS constraint onto the legacy bpf_d_path() helper, as
that would lead to wide-scale BPF program breakage.

[0]
https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 84fd87ead20c..4989639153cd 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1647,6 +1647,37 @@ __bpf_kfunc void bpf_put_path(struct path *path)
 	path_put(path);
 }
 
+/**
+ * bpf_path_d_path - resolve the pathname for a given path
+ * @path: path to resolve the pathname for
+ * @buf: buffer to return the resolved path value in
+ * @buflen: length of the supplied buffer
+ *
+ * Resolve the pathname for the supplied trusted *path* in *buf*. This kfunc is
+ * the trusted/safer variant of the legacy bpf_d_path() helper and should be
+ * used in place of bpf_d_path() whenever possible.
+ *
+ * Return: A strictly positive integer corresponding to the length of the string
+ * representing the resolved pathname, including the NUL termination
+ * character. On error, a negative integer is returned.
+ */
+__bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, int buflen)
+{
+	int len;
+	char *ret;
+
+	if (buflen <= 0)
+		return -EINVAL;
+
+	ret = d_path(path, buf, buflen);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	len = buf + buflen - ret;
+	memmove(buf, ret, len);
+	return len;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(lsm_kfunc_set_ids)
@@ -1663,6 +1694,7 @@ BTF_ID_FLAGS(func, bpf_get_task_fs_root,
 BTF_ID_FLAGS(func, bpf_get_task_fs_pwd,
 	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_path, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_KFUNCS_END(lsm_kfunc_set_ids)
 
 static int bpf_lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.44.0.278.ge034bb2e1d-goog

/M
