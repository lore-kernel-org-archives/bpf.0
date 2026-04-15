Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04551A238F
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776212261; cv=none; b=KRPzx1JmSsq+dphSnMh0Byk13cPS2RXl46gQD0VQxs+GQKKeWoo4kJeT/9zierpZpy+TpaumHhfKRg7oaG7r/sWofVjKvvl6Zr5sFGP/xQZodpFNxRsbZBl6jAh09g13/v4r3lybwjjiVagkqJfXiOIZoQRZvvS++l3js/+WKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776212261; c=relaxed/simple;
	bh=0IGHJhOwWE5T9jkOVORkXLDmC5UQqPZG+ZvqFGGBNS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+OLgtoDmxIIC1VH6i7BQsWSAHa87QAAMqifzZiVRo1dXWILChlOEePcJf9Jtqox0Ycm6sezZZjwgkcB00VmPSSAvRCZVXqLeGiowcWsh0pOgIHG8m9CbpL3jT8KAiZkKSMYEcwfu+W1ibekvu5UoT9whpKXxQPMjMwn2dM+7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgrNfpFD; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgrNfpFD"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c565dd3a7so2475037c88.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776212259; x=1776817059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW0MUWGRbLSlVExoTZTposzmNIaTXwWC3cV/beWwtU8=;
        b=sgrNfpFDXNeEzzJ/UtsmGKaY90kgqWRrzzsPU3SJoB11sjX9uLKvpE62TB3gucx+w7
         y8mJBuo6oQGDzUzXDoMlUKv1j4OiLcC0Y2/VfPxMhqlX7KGkiIZihb4bw1ucNqIlX29B
         s95KyblskB4pe/V+H8Ik8JU+tjVW8Ewpq4VRdB1D+gLzvAwDlrEJdKsZX44HTCSo5hqj
         SPWkC+hRdQ7sD8iqJiinxn/9TZrEDDL2v1gkvr534fIHkSq/PuvyuFIqyOMj5r/yPHpY
         zrs/ot8ZxelWL7FRu6bYlUESf9C64MnQHcmJcEGsaj6PblrAYBOr5tx6LCJ3q9xKMhyh
         ZKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776212259; x=1776817059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jW0MUWGRbLSlVExoTZTposzmNIaTXwWC3cV/beWwtU8=;
        b=Gt5JlsfvV/NihOxssN/zzkde5OxV4hOv2WBuUXiPPKO/Mo6SmHxVYo39BXdjOZjWQg
         pVPpgoHGA+zMeOdRl/8PsijIjL/9lbfFi9YjL5vdRMOGOGCEk/9zJx7nW5VbhHs2gLJw
         aQ9sHJPTrHSTib0xLWqr/qubCfq0dNimuDIAmULLgrZj7aLpQxqTeR8h25WD/i9BUh1R
         7oWKPcaJSh53KexN8VGb0zKq9MNSyU6u/EB1mHoHDo21KTbZJnZvTZgJYBir2w8DwfsD
         2jKEV8HRGx23RClGPS6i6RIpJ23vIo7QANMqQBBhoy60BrgRXVDxXszOcnIVn91KN005
         U2zQ==
X-Gm-Message-State: AOJu0YxyT9543FApNieO5U5eme1OYFGUF7mlaRq/YbdrrbHhfap9nbfj
	2VdHV7WOCK6JDutp4XQBWpKFHni5FNsjEi+6vcV7OtXwCLsi4LI/EbhXBSCLVD+c
X-Gm-Gg: AeBDiesFJZgOTYKNbpSHXpxbQXB4BY1oW/38YLQ4nalba6QOPmL1LgM+TY4NtED9Vl3
	wjYmG+aJmnQQ0J/xrj0DwhWd5RyCGoR5kUpJdf/h12xLff5RL3nC/wxoagAIDs5533J+BllM5ox
	RcxUBVq4Z6fsmv+ASuuMLs+xX0E7BCLeUVbJ5zL7zi2sccLkUPNHxs1r930SRiJF6HVW/9LZAMO
	E0cQQk7JGMRdoVnlrx9GrkECD22xs34HMdm4QRIdbz3NUaNNMxDp/vEe+5akMHvkv6WaWgoMabg
	+BeOvwHzBSLc244i4kyZQV874VvSfU+Gx82IedA/JvTvvllyCTfKCKyXWj73mfwry7vqPBXvUec
	gF8D+nEmYqZZT8TivYRmvEt3O4SQUSDgo4fk5313zYEBsxoZn9WoCfvmk7YHmPQDZ3Qs7VA1DXX
	cBt68/F7mxLyjwGPZXOluDKB/fdMTNzddNDQDerfa0Zm4bF/HGO9kLJM3ditPbn9OJU1hQCMmh6
	eGV
X-Received: by 2002:a05:7022:6282:b0:12a:796b:7cf1 with SMTP id a92af1059eb24-12c34edb8f8mr12548387c88.23.1776212258858;
        Tue, 14 Apr 2026 17:17:38 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::d8d4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm20171978c88.15.2026.04.14.17.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:17:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	ctao@meta.com
Subject: [PATCH bpf 1/2] bpf: copy BPF token from main program to subprograms
Date: Tue, 14 Apr 2026 17:17:26 -0700
Message-ID: <20260414-subprog-token-fix-v1-1-5b1a38e01546@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414-subprog-token-fix-v1-0-5b1a38e01546@gmail.com>
References: <20260414-subprog-token-fix-v1-0-5b1a38e01546@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

bpf_jit_subprogs() copies various fields from the main program's aux to
each subprogram's aux, but omits the BPF token. This causes
bpf_prog_kallsyms_add() to fail for subprograms loaded via BPF token,
as bpf_token_capable() falls back to capable() in init_user_ns when
token is NULL.

Copy prog->aux->token to func[i]->aux->token so that subprograms
inherit the same capability delegation as the main program.

Fixes: d79a35497547 ("bpf: Consistently use BPF token throughout BPF verifier logic")
Signed-off-by: Tao Chen <ctao@meta.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e3814152b52f..17d605cef749 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22956,6 +22956,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
+		func[i]->aux->token = env->prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
 

-- 
2.53.0
