Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842829;
	b=mGXFwiYhFDNGxd7lP6WxOcalS+bFfGNju/hBdtQO9teBrAVo/wdNZ18HjgBOK0o4++CO
	 yREAhc63IvpZLb28+YyX6GaAVM1WqG/6K1ue+EoiUOrL79mUBbA1CnVE5fOAVQGz+mtrV
	 1yoEyiuOik9DNqCy7/wK1UwUgLN5eShDDDVWyi+hxyhmHtL9fuE1uflR0ly15TKiG/KHM
	 5d43YdYWuuyaMtjPtJc1WkrhAkzbeSxdYWU59JO7NE5byJQOKL959JsLhlZY6+4oMjZ3z
	 OnWA64lhIgHQiIRKn/m7+XncuVXnr6MqzxWhG8OZOIhFw3FfVLtjDpDNYg4IFyJ75oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0cX2BYToRj+vSyky57J2kfxPtA3MYdTKmzSXTDxkufc=;
	b=lxtOWOOkTYHK+OnweeC4MciwY0e3cgkJsKx92wYLaZAJrl2DIA5N0jtfesj1ztIbBbR6
	 923fvDfoUF+liwx+30eob6HOBvTVX/JpgqrT4NOQMcdJ3LHK9fIjLQodA8y2yvNlP5PwR
	 YFKOoeyVTIRmy2Mkq8yn+6hmGN+YuK9c9U9LXYI3vcqQmqoQieJlEfvPtIDewNXmw61D6
	 s+gEPTa6f9sybQ8g1OzBcTxAq8ZuVXxtI7XXWLzm94BViA0Z/MA85WqTeZNpsVhvBkhpw
	 ITtgFvGgKt9WrQnlcckYdaVGdRyMFOZXeuyC6PbxuMQr5NxiageLsgZZA58w2SFBweQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xDWUVnvt;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F0606A884
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 209F0606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xDWUVnvt
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so2582481a91.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842828; x=1795447628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0cX2BYToRj+vSyky57J2kfxPtA3MYdTKmzSXTDxkufc=;
        b=xDWUVnvtkSIl4apxJwp4YNy41N9j47qfcbUg0rwKWaWGxwgx+/DHcK9y1vNmmEB6ah
         4owBKnrQeoHi+TrUJII1YisYoM3/FEn25yaRv09j8NDGbqD7Tl9a07z9tXh794q2gJEG
         314/ve+kHin4zt7FknyZ8IfcnHmlZX8AZnIv2LJoHo7vPp69sBTnR9qPqRMowg6wgh76
         VF0ttNr0SNNNNKonCYH1fHRQaohhoUzsfjFwMBVUudVIxSfQjzJgTxrXsk9a+Ug9GI3K
         t0iSiC1oqRrUw48uHRhV/OP0zHdzKDSaUoW6buUiyy7Ae3ZKJ9zJWunATroZwwel0D5N
         75LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842828; x=1795447628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0cX2BYToRj+vSyky57J2kfxPtA3MYdTKmzSXTDxkufc=;
        b=D/a+aBaLHUUWGI6YqotLScTIiAFqj/IGFwFfYrWk6dz9h9N7NFAhRmZcvX6hBcnwAD
         a/1lgzfFm8bJtSYjv2RXba5bcWWOCc/ueTDPG3ER3RIy+W2k34lVxcF1DSiF3c28QMyd
         iK9/uo0Q38dbk5ZfeIZg2h0Z7wSCL07fjwDen1akTyLA9SoIbsiKF83DPiDV6Uax3V1a
         b+LY17qJZa96+n2r8Bq74AC147oACTZtUL8/smCUznyo2gQy6+lesYMHQNlKLxs3aFCT
         aIMUeLc7XMSgUaHUPnIn13UxRI77IZiYtYdjUjl0qCOVq+IY5nJg2SY6OqL68YCnGBQ4
         B1Aw==
X-Gm-Message-State: APuU4Z8wapOmVSPCbRclODNWchIqo0iDUj0pygu809dvG0MONlQZ3i38
	aNmxyJfhovBldmcP3z1FXFIPTxH9n8piiP845Q1v4G8lsu2Z8lscvPhuVMsQOw==
X-Gm-Gg: AZFdTZfoHNz1lnEk02IL5wG01dSugA3+Y4tFvTigaIQyA/CEcN/hHOlBzdpjKK66P+m
	mm30XD0Rxsi9Opyzfvws0dYP+8I54j/ZwwvaubBEv1OZu1xsoiwkC24iG/Nh1TIwVm3z2hlYYz/
	eRE2D/GEwQwvaMoHmo4kJhKr1ucwyinORU8TZjfzWshFbbY7uhdHW23yB92Q/A55q28L2NDcjgl
	V1W55sUgKtT8MHHruHBI9n/MDUkFXHIj0eAXaQtkzLy1BtjZ4skJWtDTLc7W4J/bXPzyk01Q5Hc
	3F4LO8Z1gmmhevSHLlIDvIPjdVvF5z+bSY2ActESXBpNWfOAOHgM3RcuWtjNzt7sUEuOqpYnTV2
	fKQ5RKgxRgrz1b8qiapQ1lacRfnUW/5f3mahAkAK9Fozkg4FmuDFSFOJN7+f5SyXDiCWb7rgLEN
	Cb7ca7JzFdZGRiH3nCgV4zhSMWWA61z9nbcDIQcejV+1GbzD+jbfKqWyk8ULSLbWuExqdlKzFPn
	3jON3H0iiKNX+eoq6UuVBOFJA6d2ZtFJmOlBIb877/DSGZBJWlCMSuAWz3NcakxHheVkOU31fgB
	pL6Gek+0oaO+pq7m2sCGZKkOAULW/IdrSK4yiABY7pkIAR3KXeG0B9WdrWAxtGghtzCynldSFw7
	LZEFk9HAw9WnH9sbslbtnmNj+/spgJ5FMg7TpoeL+NTJ0zoDgcKVyBAkVZdmUEpY8VeOpSi8pug
	==
X-Received: by 2002:a17:90b:1cce:b0:3b1:64d3:f308 with SMTP id 98e67ed59e1d1-3b1b0a3c0f6mr10910808a91.43.1794842828117;
        Mon, 16 Nov 2026 07:27:08 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d282fdsm22550099a91.14.2026.11.16.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:27:07 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 06/21] bpf: Resolve BTF structs and arrays first
Date: Mon, 16 Nov 2026 15:26:11 +0000
Message-ID: <20261116152626.4032587-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

btf_resolve() does not see this loop:

  ptr -> typedef -> array -+
            ^--------------+

The walk from the pointer stops at the array and marks the typedef as
resolved. Only the limits of the later walks end the loop. The walk for
special fields is going to lose its limit.

Resolve structs and arrays first. Then a type that holds itself is always
found. Such BTF does not load any more.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 242b011ba93a..fffde271bbd7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6015,6 +6015,22 @@ static int btf_check_all_types(struct btf_verifier_env *env)
 		return err;
 
 	env->phase++;
+	/*
+	 * Structs and arrays go first. A walk from a pointer stops at them and hides this loop:
+	 *   ptr -> typedef -> array -+
+	 *             ^--------------+
+	 */
+	for (i = btf->base_btf ? 0 : 1; i < btf->nr_types; i++) {
+		type_id = btf->start_id + i;
+		t = btf_type_by_id(btf, type_id);
+
+		if ((btf_type_is_struct(t) || btf_type_is_array(t)) &&
+		    !env_type_is_resolved(env, type_id)) {
+			err = btf_resolve(env, t, type_id);
+			if (err)
+				return err;
+		}
+	}
 	for (i = btf->base_btf ? 0 : 1; i < btf->nr_types; i++) {
 		type_id = btf->start_id + i;
 		t = btf_type_by_id(btf, type_id);
-- 
2.55.0

