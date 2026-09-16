Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C313C109A
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535321; cv=none; b=NeKv32kLqtdIAK3kv4fbFhUEGatyPd57p8M6hWTCcdF/csXqsCnbScmUCh7VBwk48FS+SRihXgmquh1wSft7FM5rykWuWCeXdMbfnNBqjeG8KirtoMCzh3ZLI9zHqrr15Xf0zS6MvLbBcbe97deIyn0QJ6Dmill1VxXjBXAPgNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535321; c=relaxed/simple;
	bh=J80yl7pSeu1aJfefCtPfA36j81IPQ16Uf9GsjRy4ypI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wltf66d7TB3Xoh8tHHBdpkCEUd24if5rK8mtkhy8X5LXzD3BzkDB/qVKG3AQWdld9A0HihvbUw6ywa0gymjvD7rMYPmgF6JuYhxl0+bo808+jNxwEzic2NcR1kC8JxpjRKMpStTViFYCQ//7Ebi3SLhKT9WrOFftcjTWzsCm4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CBZV1qX9; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CBZV1qX9"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398beb616f5so151540a91.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535320; x=1790140120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=02XHkDP9g5u8iUqxCMNdoLYMMHIC7E9GJphz8qfrxd8=;
        b=CBZV1qX9y/6ieDA1u7zFLcdTSW9lxsBq2OfRLG+gqUirQbXk0dpi3xArLAfThzGTZL
         ePev5iWdXH/RRi8u7L4lKGbomhdsnPaKFye3DFCq+zlEflt0mniyVYEfkV4OYbEXJsn1
         6Cu7am0dAjZ0oyxCc5RbRDrfBjazcaQuWkzdILMe6DlRlTKoBbkiCw1JXeXhZtb5pcNO
         lZsxuuFBJKfqNeDMrmcvi/pylA897xY2kIL1jl9ptdaQfPfsOQTV+9ofJPB+Wp9dIxUa
         XLHV58EBez//rshBd+JnshnnUa7OGVh7tqbrmlV2e6wvHmUiEy0VJegs8gFIDftwHSVM
         lKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535320; x=1790140120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=02XHkDP9g5u8iUqxCMNdoLYMMHIC7E9GJphz8qfrxd8=;
        b=sGTfqmQHDdLSdEDQ5i4d+MEMgUY9SgRcA0nUt/N04XUNXTxIZjWQfTZO1VFMP3Ffy2
         So0sKsRmcNkTHQN6vBXljtlEEVrRmxZhVLZo34WXpQMl1WGAFS6XLpIGnPIrWvxO1r6I
         GmjBIhcMCrjNTOnZzSjvq66K/RkydvyvjgwogwvHTWz637lnWggLeENzv2Fnc1vz74yt
         POTpcQhu8lCwe1MBmuQ1G3LjcL+6PzwAYxsO+9baZgeP4QVl6MZxs0GIz+JV4LEHanh0
         hmxfrHXlYg9o1Ri3dh6qFvMobyXVw1fhCNrp9CZCFV+L8FF5068l/cOM4QBI21W4yNo/
         l7uA==
X-Gm-Message-State: AFuF++mufI2ZvdvCgRPSga6YNxC1wwQ7Zsk4OeGbW5kX4XKmtmTmQ7vl
	AGeE0U7eybCkb4bdgCaNWeE9R3Z4sWrRhF/wrUlU8TUE+zKtzKsyymHVYmO2x4SaEzt/78D/utC
	IRkYuyEc=
X-Gm-Gg: AYBFou3olqlJsMVbMem8rlRfG074DDudaooWAJIo8CAfsGGAwAFDf0ChTawO8z+ca0D
	l5yXV29saSNa9mz297e3pmPnwgixw5Dq6heKjqRHBbM6x0VEdDHfLgzBvOZG2bfxLCOWjSy5pvH
	7/RWajk8q+WaMfPFrMFSiCRMZtJx5SjckLlskQQ44NAq4HqAbF5+SE2XpqRk+tYZdvn54ULs5I6
	bZyF0zweo8n/Ml2flC35QUsBEwBJWr6QKGBpj8+HGpO8m8hfAmQck/hMQwuFKZO1r3sbTWTJZbT
	SfTkgXaEmdJDuowzeFyfZ1B+0LuTuke6Kl4FdNJOg3Y2186onHlqeMeEqrqZVEqYL3XQ1wQ/6s6
	Bn5XNhyMV/1xLWyMjfaHswf2u5oJ8GcWT8sL22FXtxXfeJQvJxCVHz1s6wZ2pfSzjPqDKroVRW8
	x1GnYFDxAD9PfOdev6lg5fuLoiAPma2r9Dr/0Op2iVXdwDHU/l7UYZWJZZB6i1VTepcf87uFCZ7
	5+o4LUrqkoRHyWs1cKpKexW8O5JM+0OOvAkmgs=
X-Received: by 2002:a17:90a:fc46:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-39e1ff502a0mr1231132a91.6.1789535319534;
        Tue, 15 Sep 2026 22:08:39 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:39 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <nicholas@carlini.com>
Subject: [PATCH bpf 05/11] bpf: Reject pkt arguments in mutating subprogs
Date: Wed, 16 Sep 2026 05:08:23 +0000
Message-ID: <20260916050830.8774-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier tracks changes in how PTR_TO_PACKET registers'
bounds are modified across subprog boundaries. PTR_TO_PACKET
registers are actually passed as PTR_TO_MEM, which is assumed
valid for the entire call. This is not the case with packet memory,
where a pskb_* call may invalidate its memory region.

Reject BPF code that passes PTR_TO_PACKET pointers to subprogs that
may mutate a packet. We cannot pass the pointer as a true PTR_TO_PACKET
because we would also need to somehow pass the PTR_TO_PACKET_META
or PTR_TO_PACKET_END to the subprog. Since we cannot avoid representing
the pointer in the subprog as PTR_TO_MEM, only permit it if the
subprog is guaranteed not to mutate the packet.

Fixes: 80f281664f5a ("bpf: Support pointers in global func args")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Suggested-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d852..507bc14b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10375,6 +10375,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRITE, NULL,
 					  NULL))
 				return -EINVAL;
+			/*
+			 * PTR_TO_PACKET get passed as PTR_TO_MEM, preventing
+			 * us from adjusting bounds tracking info.
+			 */
+			if ((reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg)) &&
+			    sub->changes_pkt_data) {
+				bpf_log(log, "%s is a packet pointer, but func#%d may change packet data\n",
+						reg_arg_name(env, argno), subprog);
+				return -EINVAL;
+			}
 			if (!(arg->arg_type & PTR_MAYBE_NULL) &&
 			    (type_may_be_null(reg->type) || bpf_register_is_null(reg))) {
 				bpf_log(log, "%s is expected to be non-NULL\n",
-- 
2.54.0

