Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351368;
	b=v0sipKAFnA+rwtgs7+HLsnfgIZ/PduihgWfie4Itag0b0sy8POUtSlWCWmR+eV6eDKYQ
	 c4+2/EELt17picGhLEJssAeuRdHU2RZEo1AhLWXD9JzJaSGsH3JJlylQlfqYbbSiBxdu1
	 y/VGu9M6Qm1m0BykV/pLwXxVf3ZM/fCpXc3HwPoIPQZK6qM9uO8czaM1r+zZKPAsC8v5A
	 IUO3jmPsA0nQhlqDbbsdvW/PcB9eE97e0ECZP/gL+NwphKky/fX8qeq3BwfTPNfrktj3w
	 VOryxmDFPlCATEwkdqk1KiQevi2NiCiqOWYOf/9zAhQ1fofKLuKbjbQF1Va4YM0MjMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LUvsIkp7/500y2lt6LJqZ5I2WBJLtnIUyPWDTSgmUgE=;
	b=DjTHhEWRHDXv0xnNgpNNy4hs/sXZkq9lAIk+NSWTH8e3w/pP0fnX/eNe2NHA6kERMI39
	 kW+T8HSULUUD9KZecu7Sf4G/opplo0dkBtQGa0RY7GmQtBMszJOAKq/DkkgYn7PS/Aspm
	 1Cy45xRz29WwvdopH9pg02V/TRqzygB8HhsCmujYpZa1QsA3GL3qcgwCc9igMxyAFfSHR
	 E/O/2yWQ5UQso8SREmFda9unWlwiTsHH2SqyKPbEey93zUyXjY32N0S2PjFyZCJtkVhr+
	 +49XsgmrFQ4kT1zIDaXdHgIeiYwHi+p9HS88ub2vQRqogdAUac0o+Q0qS5eWEMnYVcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EKaukWJO;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075AC606A322
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 09:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 075AC606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EKaukWJO
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso469701eec.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 02:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793351367; x=1793956167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LUvsIkp7/500y2lt6LJqZ5I2WBJLtnIUyPWDTSgmUgE=;
        b=EKaukWJOmlmCmCOrqE+396RTZy7uu2qczhHFVxe2WkvPErEZOwSM8MHKiIs0xRxdQe
         +LFbi8JWToATxv/nKr0XWqs+RIFUB4IrdGkcV5h8VLfm51c/ffquyPovtniSGEzoK1cB
         bX+wT6khbrU/tWkE9O+dCpXdN/k/oJz/ZvIgxSWSh2jdBru6Og+giSGqgWXYWUfSTraZ
         yNcvYVdabJ8QO38kYkcqwEoweGeFAXSRBtMu6hcya0G4+FTZvb1vaI1yekxWtNNo8KZ6
         Ur/AfWe0v9k7ibSRldaCr2FWhcO0/iAQdned1SxwZNrpuRx46RUmTv7mfITbLUjKWP3D
         JKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351367; x=1793956167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LUvsIkp7/500y2lt6LJqZ5I2WBJLtnIUyPWDTSgmUgE=;
        b=QobF4jeynld1a5fmeWdiszHHh3WfCj4ysPdbh5pK7Pkn+jQvvaCcrg1YXsfMR7QJoN
         C+hTlyW4IkCVE+zSA+87dxUUp9cf/afJHbaaSbZbo2qlfhjqliVXRE/4WVNGSQCNNaJ8
         skQny+h+rjAgZusQeFqvauyHa798S5CQm0q2pJE1em4wCQhhxoiQTGoflu4uAycMjy56
         MNdQGqqF2Ins3dcNttwZpDvAUs2bDmjpZrxCuPDdr0XhbzRpISbywmBcnplfi6MrzBfV
         u5eZdyMl+wSwka9sNIC8ZWC4pPS5S2fTTWb+A3y+Hu5fKjmMygEDsX+vWqfdtaEzUhJV
         gZCQ==
X-Forwarded-Encrypted: i=1; AKwUvBymUG6v76OPJE46NS5jnYW80n2AVYfPp9Px1w5ByyiZFMHTRhnxJ3zpyij4FFt/C7m+9tg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAVKBmXEhqI3fTo2zl/6Liuwz8+kcX6SseW7W/HkJemNrL6j1K
	2s4xw2i+w7zdr6Qm5DNM2XUSNXC9CGp1DKusMGaBxX1SSkBULi03kPMO
X-Gm-Gg: AYBFou07+p+im0GPhncCA/MhsFeMRBbwADfSaHsf28P9OpOo3WopoqkO8s8LICqabnA
	oUw62J/TeEcEloCynIzi6vxDsJ98ochEERTNFC3YmfTiXzSskCyWIcb+QmBo1BSHdG9WquNKSc/
	rss71Vzn5uWfaIs6Pi52T7CQhQ8P2k2jkCkyOTElaYGzEJE2C8ZGyGlmbA9LyT9ozRPN8DXsU4L
	vicJ0oSu3zOAhHf3s5p2iM9oo4pkdAHiDLI+U35CoBVrgOtCFLZbmaDkqtEg2HFzLsRtaHY/smm
	9XADNqghk4g+ycRC0nDbSP0IRGWAtPHpQ51MbUxFcTgo5LIZkDpL24Rp5kq2x41BrwzeMBcmZlD
	STJZJ/Ei+Tg8eTQgamNRmHXLx6q1PZqhbgSbrqXrNUGfK17B9q6huyMMjmB45rWQ0dFfrx040ca
	ONBz8OPXOaUOlRiO4LwiaiAOHNz/Au+A3DNJ/w1QurHglcrHxYIqWGfY+f/a8Q+TFD/sIqX5I3N
	zrnOO1MYYFUtgw9hI7LwB1P+pKPTtw91gpUTaHKz088f9+zoaXiaDn5b8zubBR1Pbii0f6I9QVQ
	1dHvqxvw6SObm0aHSc/9DC/N1RIDchaLWdTC4buR53oj1oqBoTQy2ZLyKQ==
X-Received: by 2002:a05:701b:4244:10b0:149:1b5b:1f25 with SMTP id a92af1059eb24-1ac5b211405mr2439430c88.15.1793351366854;
        Fri, 30 Oct 2026 02:09:26 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4a04esm5371762c88.15.2026.10.30.02.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:09:26 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [RFC PATCH bpf-next] bpftool: avoid sign extension in unsigned enum JSON dumps
Date: Fri, 30 Oct 2026 09:09:13 +0000
Message-ID: <20261030090913.76944-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The BTF enum value is stored in a signed 32-bit field even when the
enum is unsigned. Passing it directly to jsonw_uint_field(), which
takes a uint64_t, sign-extends values with bit 31 set. For example,
0xffffffffU is printed as 18446744073709551615 instead of 4294967295
by bpftool -j btf dump.

Cast the value to __u32 before widening it, matching the conversion
already used for plain-text output.

Fixes: c93cc69004df ("bpftool: add ability to dump BTF types")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 tools/bpf/bpftool/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index abd661db91e6..385521e6b028 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -482,7 +482,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 				if (btf_kflag(t))
 					jsonw_int_field(w, "val", v->val);
 				else
-					jsonw_uint_field(w, "val", v->val);
+					jsonw_uint_field(w, "val", (__u32)v->val);
 				jsonw_end_object(w);
 			} else {
 				if (btf_kflag(t))

base-commit: 7101b10cf281f629ac58c99697ca6f6d082b99a7
-- 
2.43.0

