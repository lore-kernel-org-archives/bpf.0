Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C5A21CA03
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097652; cv=none; b=Zwy5quJFI0a735duEIu3AtJqn/1zBNQvz4ZHr+yE7Q2Mv7scv57LDZNepaUOkJZ9LDrOmxcKB/JtUrcO9XuHw+wJCO5J5/j46JPnpodqrMM722riY6suivtPmgmW7YQ33yurDBCKN1bmUiYZvk69WLzC/UmOWbAxHMAk74jgUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097652; c=relaxed/simple;
	bh=30cLnmz4cWHRxJgdCWlvpHPK4mBq3gF2qxAVsznWk6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALMqiiigjNt7E2iCo6dXLiefyoHQADSPAM8yQDtsRGZYWSiDQ82xcdSFvOnR3DPl7OSGZddjIYgFz5cPN+U91FpvHw50xT9mWUO3zGXbBJPhkgRHrzmtj06bQACFU+uJb6SdawVHnNg4wwa5m+SkzrIp2a45u4WK2W4rv4Vp0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUdvF52X; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUdvF52X"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-448cf99c133so274033fac.1
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 23:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784097650; x=1784702450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tNHzuCnC0D2KhE508VIUPJUzkADPSJLwT3pCSrFgwu4=;
        b=YUdvF52X1NDCPyM3TzamyHKcP6sKrzuYCtjOrJqqfyUGGPCadnBACsnk2pJW77bS4E
         iNfEwxfT4kmLUIinnvQLELlwRfRHbKZyEYT8Q72Xa1bvNTRLFUiNcvcA+nR0T4Xj/pWY
         CWnqU5lG81QtOGbD8Dl8sTgUhdlyCoxaHKtVD41Yu5BmK7Qk4qtxYOuLfb1XvFWj/ImX
         H6Ti63mAFip2+aUh6mkZV0nNC6db+MFGd2d+hMLjvK/1N7jx6XtXcYbAldhL4J7bRD3Y
         NMJgh2iaLVxuX4amZtSQWx/VUM9/0c8AEec1+yCj46ka4ZM+3KZ1IuIsD13PwbzkU3Ph
         n2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097650; x=1784702450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tNHzuCnC0D2KhE508VIUPJUzkADPSJLwT3pCSrFgwu4=;
        b=YawFSuM8Gb/hCVhHScZsKKmJN4AUrcSHKXlltDcAxU78kTQ/H3V7yjcW8x+9JLT8C0
         X7PfTa9mA2lMNqdXBhOMdM6YkU6J8b0YVtQBjaAVbDgnF05+DZk5OgusI/0GAWSSXSg9
         5UKx47Tu6FR8BZmUi5hGrQrAHUZmWA87u/9ybD+NAM95lNX9LsNdPaFzDAH6djEBM/Xw
         oGtLnuf0TDg/vyOUJyhLPhP35Ls430auRbFvj09uadT60sE7ztUJGR47xeX6igHFkl/+
         uSUbATuxUmJb+dN1TyFdKX8IeExnzP8bvOCLTdMZ6CsQ36WqZzNfh8u+SIj2iskFY5MS
         Hxeg==
X-Gm-Message-State: AOJu0Yx92VsZwKzxTyJPwRaUuoT+/B2Xnh2YP3vB4+t0u5mEAuOCFpOK
	TnboWur/Xuu6295yWH0QwliIfZ/lKuN9R5hQsMEVBJrNEJEaqDpXhWdFcPI9Aw==
X-Gm-Gg: AfdE7cnLUZeC24SoLXCL77krUE0j0Lj2FCfFqzvivu4T8EaqnjmfZzfZ23xmsQlOC+N
	U85KWsVq8rUOV47nJDHMFaa5tQx/GogzaGU3VRRfrWaI022vjYpjLx7XRJfL5fEXfixSjXVAPKc
	w7ldt/ACeu0HsaVEsXxmYMbUi9TH3LUFXIFREYHA6bjLvXQL7i6uDchGr3zOCu9y8t7wWRpbwSB
	pabuwgclNglqmEnKBBjCBdOx3z64Qqbz6xsP+iJl2pLEspVlZ3fa1SdfKuZXFWT7io2ZS3FSVjX
	ILYAqtlY/PZSjrlxKSsK9BIf1hLaetFoU5Uk343mWlcL1FLRIamTiMqEASRPKsOVqnd3zRMqR+u
	dBb5bASzJmwxghNOIb4dA23CkIdeceNFcSpOxV4KQEIXWG6MDVljQxsraG6O+d7tX7hkq4K/erW
	4PpZE=
X-Received: by 2002:a05:6820:810c:b0:69d:7fdb:3416 with SMTP id 006d021491bc7-6a38b9a0e29mr9839804eaf.21.1784097649992;
        Tue, 14 Jul 2026 23:40:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-451916f31d4sm19097847fac.16.2026.07.14.23.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:40:49 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/7] Unify helper and kfunc call_arg_meta
Date: Tue, 14 Jul 2026 23:40:40 -0700
Message-ID: <20260715064047.1793790-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I am working toward unifying helper and kfunc handling in the verifier.
Historically, kfunc verification was mostly done separately from helper.
This causes code/logic duplication and may introduce subtle bugs as the
same checks are implemnented differently.

To address this, I plan to unify function call verification, which will
operate on a common function call descriptor bpf_func_proto.

As the first step, this patchset merges bpf_{kfunc_}call_arg_meta of
kfunc and helepr. The structure is used as a scratch pad for different
helper/kfunc verification mechanisms. The previous object tracking
refactor patchset has unified some of them. This patch handles the rest
and finally merge the two different structures.

The next step will be generating bpf_func_proto for kfunc before the
main verification loop and align kfunc and helper argument types.

Then hopefully helper and kfunc can go throguh the same call verification
path.

Changelog

v1 -> v2
 - Fix patch 2: ARG_PTR_TO_MAP_VALUE | MEM_UNINIT should also accept raw
   mode
 - Add patch 3: making check_func_arg() less verbose
 - Add patch 5: a selftest testing a preexisting OOB access bug when
   0 is passed to a kfunc's {rdwr,rdonly}_buf_size argument
 - Add patch 6: dropping pkt_access from bpf_call_arg_meta
   

Amery Hung (7):
  bpf: Remove dynptr check in check_stack_range_initialized()
  bpf: Factor out raw_mode-related fields in bpf_call_arg_meta
  bpf: Pass argno to callees in check_func_arg() instead of
    argno_from_reg(regno)
  bpf: Unify helper and kfunc allocation-size argument handling
  selftests/bpf: Test kfunc returning zero-sized allocation buffer
  bpf: Drop redundant pkt_access from bpf_call_arg_meta
  bpf: Unify helper and kfunc call argument meta

 include/linux/bpf_verifier.h                  |  54 +++-
 kernel/bpf/cfg.c                              |   2 +-
 kernel/bpf/verifier.c                         | 306 ++++++++----------
 .../selftests/bpf/prog_tests/kfunc_call.c     |   3 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   4 +-
 .../selftests/bpf/progs/kfunc_call_fail.c     |  27 ++
 6 files changed, 201 insertions(+), 195 deletions(-)

-- 
2.52.0

