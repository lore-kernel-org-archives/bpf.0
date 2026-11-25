Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594397;
	b=zyZnGwTwTQXH0reUgxmlFZbqJEEoV4hq6jtPSMmIQSbRJo0CzKGGc20BtBy1Kv2Ckdye
	 fHxkvak2dNMDZCDDpxXSaEHHvsVkxtLeh9tC/g8FSSEkqk0gGSddcgko9KdLxpnvUaXib
	 OY/2J/wl97U/eVVu+xEqPJVTE9PkGdof7KewJY6egiI5RnBXLOXB8mfHQB2YFMFd1pq0q
	 SdVRJNI4IR5RDH9qF9pHfiYynlvMq0JE3ZwqVbYlD8Rnr8Gmn0YAx2cCQO4U8EICL44Ja
	 1LmS56ECA7NujWfzmKbUCgB5a3RCjL44y5pc0H/dOqJ/4EMTEDGf6G9p5Zvne6yMhwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2QHT5GJ4qZi7ncNmGPt18IUAQBZQUrxx2H1DMijk5Lg=;
	b=tPUWWiWa8qP38mFn7oIHMyGZu0a4YnvX1b8q4zQNAdGcgQxqBpEKiSdeQcastDN0pbMH
	 ucDeH3bd5m9TW96Q+oJxzyda7BKPAEkqnEYRC3pdBckcNdfhOvbrWQV+vvsA1PGbxb2Nj
	 j9wjgk0wd78TY/V4tQF1M9ZAN+L/5bfRCh9z2yEzabqj8w4rOn2fH/riTx5GjkvsN2nlf
	 GV+pZ0Ijs0eOPqnwFstOY8QeNQh9cTiafvhhQP/Ok8t0yLbfpgB8wlC4fGne8Ug/1fy5r
	 0/Mox8ReWQjpjdLqdBIhs6aLqfaQmCca5LDUX53WUZoi++fcs8kAHOtMq5Peo2lD04g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J5mFQDaV;
	arc=none smtp.remote-ip=74.125.229.131
Received: from mail-dl2-f3.google.com (mail-dl2-f3.google.com [74.125.229.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B0606A335
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 08:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 778B0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J5mFQDaV
Received: by mail-dl2-f3.google.com with SMTP id a92af1059eb24-1521c45a248so4831863c88.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 00:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795594396; x=1796199196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2QHT5GJ4qZi7ncNmGPt18IUAQBZQUrxx2H1DMijk5Lg=;
        b=J5mFQDaVHjb7tt6wnaez/rnR/zDv3jX/sjGZKII32hjAYWYvo1NPOB0quLoFkXDWjz
         yR9O/QFa5RujlFva2mz08T7NXX2FnWLc6+nmQR61cCBpfMFgy+hBOk4C5kqgeGF4eWH8
         2Sgee5BiAIaUotjyN5IKZwC+QBLDE9HKQmIUUASpbZZKaFILvw3shdU6RD/k2D8QC3MB
         bKgrDk4kaACxfDlsHSZ/TV3I2MsXiHQuyCvfG7F0bHLQXbra1wKco5GibqzNFFBy4687
         lHjXP5QUZ3Dz4QG4bIJFupCjBQvJi2WLCslYKQzfIEXup0knRr1x53vPRVX1SA6pFbXI
         WhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795594396; x=1796199196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2QHT5GJ4qZi7ncNmGPt18IUAQBZQUrxx2H1DMijk5Lg=;
        b=wGh2MiSIo9g5i+cOhV5iJsWPPMzMup744sSRrcH5J+PoQvUL2ScDRaYVSTBWUg3HON
         FQq0pJXC0f1nRvHQoEl2mbMI+L+7MGZKQTIkKAaoH0Zi5Lau+ql4O3BB4Ip3polTMi1V
         wqMSGKIFOTNMRv4B2/xK7HZqgHyr9FZBiKTrEWSTKeNIrfhp1cQUYh9s9JhxKEI9hT1J
         6QWOcMSVKhw0o/vndQefI6776xG34narsl0y5DuG0tDLj+H+282acSrtiA58WrTCVN0E
         yghUwPxjUAtnEwpz0rbDmPdDXEOm5tWXsJhuWEIx0DjZn+htiCvJhMhtWSMN2MoPlCrI
         xmdA==
X-Forwarded-Encrypted: i=1; AL+hErH1ZnllMliNkNmJ4yrqVfcGnGzCr9S4bTeOH/m+3QW7r1VoVbLaDp2cMjNYYUqUvRa4P9o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fWbI7Ag5QpisTjBynbK7EnRGjrPUzehTFLbzOUtx4PYo4w0IX
	T+yWXzF0UCRAnZ/3qPmI/UajQivD8TLpk3ET+nWhMMc2b2lM8aGXpDVr
X-Gm-Gg: AZFdTZeT1bsXiTSWmYCZVDaSr5zr8sFUSM34dFNlxh12JxuXVfaxNCcIQxdJNUhu28T
	KuOe7lRz5WoqXNwuRqIK84gEKjYjbEr0gj37o5pIqqugEJFP1XfRE/RYS3tl2mo4pf8qmN92CpM
	h27LTA6QvcK20b9RZ4bkuN7UTqr/HeAOAP8UAVS8bUke6tRu/eoMmxiKgHAk0AsPPtREoDQFRfo
	bXEuOqRTF0sIuoL8eSqPQcXpeP7YTTnRN3HBoqFdTQKCenS+9cXiF/SWJcMCzbId6fbFyepOox3
	ghwQyBR2zJsmX9szzqrINh5s1MmRGBvV6nDYS8VES1U2UkqB4Ja/l9fFCmq9YtONmmyKO1r9Au2
	xkS3YJiw2uZPMYur0f+1/AObtRplhwLW6Oj4w9The8nHQkz60LU4KrI5SDKcbBI9CXmt3QOyhYK
	Z2ZbaqyRGXdc4K7DRLd+WPYi6dzam1T6ZKnAWk0ArBfm5NxvszlaLE7MoC74/Uh3VDhya8Dg7ra
	fOwFxxmUTcPr+bImT/LqutXwC+pF6hbipvNTNu3gnakh6O5BUW1wbvbz5GHdsLz8ndjnK178281
	Vru9hvk6OxghM295c77Bsa4kb91IcXyoh7P47kpjZrT5cCkTM3CSYbCCvMJzIXr/btZrewItv73
	164h55caZkLGkvk2H3hotreVEDjoHodL8xsKeug==
X-Received: by 2002:a05:7022:1103:b0:1b3:b3de:9232 with SMTP id a92af1059eb24-1b5568a15aamr15118215c88.9.1795594396325;
        Wed, 25 Nov 2026 00:13:16 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm39484090c88.15.2026.11.25.00.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 00:13:15 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: andrii@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	alan.maguire@oracle.com,
	dennylin0707@gmail.com
Subject: [PATCH bpf-next] libbpf: Fix dumping enum bitfields on big-endian
Date: Wed, 25 Nov 2026 08:12:45 +0000
Message-ID: <20261125081245.74091-1-dennylin0707@gmail.com>
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

btf_dump_dump_type_data() reads an enum bitfield into the __s64
enum_val and passes &enum_val to btf_dump_enum_data(), where
btf_dump_get_enum_value() loads t->size bytes from that address. For
enums smaller than 8 bytes, those are the high-order bytes of enum_val
on big-endian, so every enum bitfield is dumped with value 0.

Pass the address of the low-order t->size bytes of enum_val instead,
so the value is loaded the same way on both byte orders.

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index bbe86928b3ec..08a4bbbf4ffd 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2665,7 +2665,14 @@ static int btf_dump_dump_type_data(struct btf_dump *d,
 			if (err)
 				break;
 			enum_val = (__s64)print_num;
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 			err = btf_dump_enum_data(d, t, id, &enum_val);
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+			err = btf_dump_enum_data(d, t, id,
+						 (void *)&enum_val + sizeof(enum_val) - t->size);
+#else
+# error "Unrecognized __BYTE_ORDER__"
+#endif
 		} else
 			err = btf_dump_enum_data(d, t, id, data);
 		break;

base-commit: 8dfce13340aeba06d1b68cc7648f37762244be65
-- 
2.43.0

