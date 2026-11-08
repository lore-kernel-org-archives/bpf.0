Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154281;
	b=ECqT7CwxPDLesD3rSNWI4+KbkdLNWbmAdi9DiX+hT9HGd4caCRTgkmuBzUISYQ+IcJTD
	 jhuXD+fkhiGIgQUncxarFoTrj+02vzOnH1VR6FE59++RQ7ZwUmYG6Gr7EU/013fhdtcGt
	 68fcWAyFSs4GCYNWO4EgbkqV8UJ/1emujw2551xVb9FBsIEWKTTuc1NTJmFrmZR2cjaza
	 mmIhx7Z9+fsKuPMRyfrwdsck7vKsNAPfaStsNQdveiy382+3sRnmw38vKV2Q4auiSXNae
	 sMjNdy3Mw65c4EwRHiSMlfOejE1fbK3Qhs/csB8g85Khr5Rzva5zJ4KvThoiDIeiYIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=u62mdNNO0wcKly6E1FlXgxjlcVAqw4rRRSgsujyRuv8=;
	b=muyxGAtNbeiJS1wSGk5xY5/gLBGeUmkxt89LesWtQwsoAFPUes+oyBP+Go9lEcWcqITO
	 wLj9GzzAqaddx4W6BFMANnHr/QnW1pBQaAQh1mLsFtIA2/+2Rzi+uP6F4x7iuQYEdglZk
	 +uzeaaC39P7Ks6p9cxOG1psRsVVoTPck6AbvLEPUa4glIJENgWB2zJc8vLQ093mxu5nkj
	 eS1JJldbb3DwP0PeqMMUJPIQhElmXH0lHS93e6OKvfLF7MeMwN1GDgtPSwKg+Zj33D0NY
	 B6Y2d9/wRKnc8LH+V6VDdwiHCJO+lmGvpZV4N764EAJiDf11VBx0z236VR5FuXAsb/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uzSQBr96;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A51606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 16:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A51606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uzSQBr96
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so38838a12.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 08:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794154280; x=1794759080; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u62mdNNO0wcKly6E1FlXgxjlcVAqw4rRRSgsujyRuv8=;
        b=uzSQBr96+nrMkBTIuIqvrGZZ/MZ/Hx2tSfjGmp6b1nHHzDT5TO7ijYTVIqqj8n2qgs
         dvtPS9sWuKSeXSLa99E+y47ahPOarOxMhp8DJI5yDIBDh44GIQd62oHSMPZssgIYRIaV
         bDoTaC+XkviqaeqhXyXLfQtko52XaNnKwb50LCgsazAxmPWkJJfpg7Rt99/+K7fgfT1/
         AyI7LBkptpzqQ6eEh76LCwOfpu3YmnHajKw1eQEcUj3a+lOX+71DoONynTWTbNs02rql
         AZYlZWorast3+FI4NwW/mOi2/vyZ41UNpeoq/cTdyj7kFfH79eRR423OiSfPkBD4tj5K
         k1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154280; x=1794759080;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u62mdNNO0wcKly6E1FlXgxjlcVAqw4rRRSgsujyRuv8=;
        b=rdd/2VAsvjPuWca44R4CkVmu5GJAHlFbTb+ndYj3H/MzpRSJQB20m6kw0HD3IzrO38
         Gmw4R4Q1l4zRIAEamSvN++z8Mz5CtNP3zLL4/U/6am6WklLpnlYmyYU69LQdTBHp5Q0q
         fEDwtA84PBWr3sP93ZISkSxaIIljmwNZBcM3vAXzxecLUoK+bKlu61LoUphS47TISPcM
         hNTYLm3IwUUKIHYK5Bo0wD1aUwmqkKZKM4tHKhd8cBfVifiNz/6iU31H6Aq85p5vjh60
         N+yWzHcK6f6d7UMvHak4AbbAVlSDzwypnxRog8zxd1yS6lZmheWr5hHoMTgSeyv4OMt5
         Avaw==
X-Forwarded-Encrypted: i=1; AL+hErEgb5QkRLmkqk5sWBM3FrnBE0XtooPlnm5IH4imKKtyOqxkmIBoULxirH5gelcCFeK4f44=@vger.kernel.org
X-Gm-Message-State: APuU4Z9co+G1lsKxbF9SqsPbrbG8ivEJ87CHeFbb7P+MKQQWmQ1r/Tzk
	5LH2rTH/4fUAkV9iQJunGduHYIQFG9t8LWDlMSSbp8YDdm/xb03CEqN2
X-Gm-Gg: AYBFou2eHqLXYr+a/5oy96gmOwG5S6LuXrvImVI560SwBM//5nbzosP7LOBV6EBRazD
	CDq7yKWRgJ6+hjUw8WQQRDFLp3Bio9fDAURs8nAO5ckyPkTVwBXiSrunncKwyjcFBv28bnmvkYG
	K58vtvwrB2wDAeEZBPjJUHpwm4eYxHOvUEMZcPDT4HOXHODB85gD2rnW5X79OEe3LKMsEIcLYjQ
	4Tb3daAaqe5L/zlDJY086SkLox7yYRhLNo835ToPH37FUv7meZabGdVEi7Sca0Cm/vMjPdTIkbW
	oktk3rbPKByxpEhaN9r0lH5P7qKiHKZImV+odaVSaGCgtdtRJdDhwDPAyRO74WbMj6Vi5GltZPS
	fNBWJ1BtW5Q3VBDv3+Fx4ShtSxu4rsYn3fTYP02pSKXnQUhUgLqc8FYWptbKoXtW7MOFxa0tiY9
	UsyrV4jYqnXmkjEK/Gq+dfoGfz7UryYu7k1KXbL0YIptkD7HhNHx+UAtwlJtGAL0Bcm8HvwOt8g
	R2xXCWdj2j+h5kDUqXzYHtjN6ENNjRcX8uMEiaCfsT7/rfKf3G1xb6xYHG1tYbptEXkniUX9SiM
	ig5B4vm7J5JIlkRXPhjvI5hItkDq6lJFlcU7F77NfVCUA7v0w20hCwFq8O8QGPOFDuZgtfFx+x7
	uZgzIcsVWkKQkmoaOoUGhidl5TcN4ETHEBA==
X-Received: by 2002:a17:90b:4c07:b0:3b0:a7b5:c037 with SMTP id 98e67ed59e1d1-3b12d0e9816mr1520349a91.1.1794154280324;
        Sun, 08 Nov 2026 08:11:20 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105881e6bsm7484427a91.7.2026.11.08.08.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 08:11:19 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Nov 2026 16:11:19 +0000
Message-Id: <DMPYM1AW7KEU.3RX07MQ1JMR39@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v2] bpf: Check variable-offset accesses against
 special fields
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Shihuang Liu" <shlomojune6@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261108152941.7363-1-shlomojune6@gmail.com>
References: <20261108152941.7363-1-shlomojune6@gmail.com>
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

On Sun, Nov 08, 2026 at 07:29 AM Shihuang Liu <shlomojune6@gmail.com> wrote:
> Check every offset the register can take (min_off + k * step)
> against the record.  Constant offsets keep the existing check.

No need for the helper and the second loop.
reg->step is never 0. ___mark_reg_known() sets it to 1 and
reg_bounds_sanity_check() reports 0 as a verifier bug.
So a constant offset is the k == 0 case of the same check.

Something like this (compile tested only):

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8bf3909..2265362 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8094,7 +8094,12 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		for (i = 0; i < rec->cnt; i++) {
 			struct btf_field *field = &rec->fields[i];
 			u32 offset = field->offset;
-			if (off < offset + field->size && offset < off + size) {
+			/* An access at 'lo' or above ends after the start of the field. */
+			s64 lo = max(min_off, (s64)offset - size + 1);
+
+			/* Round up to min_off + k * step. The step is never 0. */
+			lo += imod(min_off - lo, reg->step);
+			if (lo <= max_off && lo < offset + field->size) {
 				bpf_log(log,
 					"direct access to %s is disallowed\n",
 					btf_field_type_name(field->type));


The store to arr[i] from the commit log. It loads today. With the fix
the verifier says "direct access to kptr is disallowed".
clang can't emit such BTF. Compile the struct with p at offset 16.
After __open() move p to offset 8 in bpf_object__btf(), then load.

The store to arr[i].data from my reply to v1. It has to keep loading.

pw-bot: cr
