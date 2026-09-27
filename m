Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A64192B75
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790548428; cv=none; b=BOjm5ARAxlvEu/x+CB4mcppg+U6u+qcY31uy87Ax2jTpP/Nv2psjBL115u0DWHrCggY5SAw/4zJVmdXUUhHu97+aLAgNiSMXPu0zk2wUWolEU+Se4n/83XkDdstLwQRmCdPxkOjuRR5jasM+L3k1SqKIIiEGrq52Xxv3mawFYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790548428; c=relaxed/simple;
	bh=1sRcSFppOrgktFqdfKHTNDuzVX5pBsaOKugd6hcDcIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AXc1mJ97f6I6O+T0COJ5a10BTbZHd/AOXR9GFsbZRB2K7HfzaeRxfE3JRxHxoXJSe6HxzmwhqJavEl0z1WPjBRI24Kvh1Bj2MLIClQHmtFU9lhxVco1VDZ19yPmJF/tbLp3wpBQoQlFd5RUh8lznRQTcD0BDjC7qAvm1x6ULVjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx+xJFff; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx+xJFff"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c5so2143159f8f.2
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790548425; x=1791153225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3HVeOlrU5+9T0TXxv7ji/SUxWihY/QvPKpNCrdEuPA0=;
        b=Kx+xJFffzOkSdRikEURxt7j+/Ww29ZE649WMrWE/UUNYDPsDIvcy4YxzigdZPU2SBF
         eGIUfv6W0k2qFwxMatLKc3n0tcOj8f/AV6u1Tbd6jqIanCo+dBG7hHuHaHckMKiQkFFG
         zMs6A0QmmXVjfnAv3ITe8mfk0DcXfi5IKu4AFkdhBxuwLNYNODEMjysTIB/6DmCdXrkq
         7d22wLlqKPDrLbV6w/BL5rXrbZfjdGpJ/4tqQ8IEuJoTOFRb8vM92xis5WT5mNROz+xc
         wQwkRvSV9Xy6FzSFJT2NGxvn2G3fvORENRR7lz0TL2cKhHmPxkQbrsyB8LaydGLorWn5
         ZV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790548425; x=1791153225;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3HVeOlrU5+9T0TXxv7ji/SUxWihY/QvPKpNCrdEuPA0=;
        b=Rn1x2F/DWxRbO8uLsZlsrg318g/MJsjhg43qylgrq1gYp6x5OopqBDUPsDi0uInEcM
         vDszT1CbKMck2RZWi+ypJTTHACr2om+l8vQwKBtKKm5lynU2o5MSZBaVGan+IEb43jbE
         XIun8kRReFYkpwdYSbgdW9DIEmXoPitAFeKKMVhffWh37wJZeSZVqDiQmk+zpsX3Eur1
         i/bOv0F4cfr+ThjAAobZZgEY8pPiKgoRP4fI37WG/6qoMqQ2ZnDjnrKLizVZ2RPocDVG
         Zac3Obbcm5OIzl3xbw7r5nxp32O0QOK27xUT6aliktz0dPc0g+ri+e/AMPv8LGDDJTvc
         pQ/A==
X-Forwarded-Encrypted: i=1; AKwUvBwC309o0f36qsJfWTCVikahq+jmytBaBWHEgqEGKRbQFy4T8cSFMD/QoFO2Sk3etQgRbPM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9rXCkWF80HKV6y7JlZDBghO1x0HdKVMS8VzwOKqxbZR55MH6V
	qgnkwGRBWUZRTqbdSmALJMA+8tA4jDcAB2+eh6YBrq42Q13S7gHvHL+Y
X-Gm-Gg: AYBFou1N4MwGSPRNqamuLpdKZ1FOkDjpcvhhQ2/guIiXOfORg3NJpryWgtA2/IdZlD+
	7NKeAdJAITn/PS/ep6Kf2f27hOqZsvikkYxA/3ZVsuZx4hzJLfuHRaNcS50pong6DKwhDHKSydP
	mVNteZI/4YuV668mLAnsm8y1Ivt+/2wj01xDEsw5MkH0LlK0oQZ1sLD93B/dueiCudIIrAdcRWy
	HToVOdQqdFaUuhwxXSqwNkE9zxcNl0EbMVmaQwY90SzPYolMew6Gdf0eahSG5JKr9JgMbnE0jHI
	MMJknRp5Y2DHgMj25+jGAAiYuabWcL3Qsr3Ub1UgYmtFd7UscIJ02xlVwCURJsPAM5LOtMPBT02
	MDgyxqLkrXOAgjtjDreTU2KVGvboOE0oXmcUPu/IprOarNLOuNc8uK0WSUzGGRwp7I+ox4Q9POo
	n3pfEtDAsl4+majGNFyrMZiKEMz7tMYEgw9WCdFLs5IWxukwGbZvleYJyAML19Mm0MhnOj
X-Received: by 2002:adf:e19c:0:b0:487:11c3:b004 with SMTP id ffacd0b85a97d-488719760c4mr20369347f8f.52.1790548424757;
        Sun, 27 Sep 2026 15:33:44 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm22517694f8f.2.2026.09.27.15.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:33:44 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH bpf] bpf: Fix uninitialized known_memory read in check_mem_reg()
Date: Mon, 28 Sep 2026 01:28:05 +0300
Message-ID: <20260927223327.414912-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

check_mem_reg() takes an optional bool *known_memory output parameter.
When the register is NULL, the function returns early via
mark_arg_precision() without setting *known_memory, leaving it
uninitialized.

The caller in check_func_arg() declares 'bool known_memory'
without initialization and reads it after check_mem_reg() returns:

  bool known_memory;
  err = check_mem_reg(..., &known_memory);
  if (err < 0) {
      if (known_memory)
          ...
  }

If mark_arg_precision() returns a negative value and the register was
NULL, reading known_memory is undefined behavior. In practice only the
diagnostic message selection is affected.

Fix by setting *known_memory = false before returning in the NULL
register path, matching the intent that a NULL register does not
imply the memory region is known.

Fixes: 66e2727395dd ("bpf: Report Call Type Safety argument errors")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 kernel/bpf/verifier.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 535967fc5f12..2cc8a2778c5a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7652,8 +7652,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 {
 	int size, err = 0;

-	if (bpf_register_is_null(reg))
+	if (bpf_register_is_null(reg)) {
+		if (known_memory)
+			*known_memory = false;
 		return mark_arg_precision(env, argno);
+	}
 	if (known_memory)
 		*known_memory = true;

--
2.55.0

