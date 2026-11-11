Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367314;
	b=Q2cB6sc8yD4hOCrvYdCQGJ1bU5pLnYldmlQx4p/CLB0z43soVoypBD8G9g/CvfR+mupa
	 mmkzu3B107QmZieoDePVoqfb9Ri8/eQfUK+b6SwD3BBeOnMax1Lmj4oOvRqLWr7RSvX64
	 34+e3kEvra9E1TmzvC4YLFp5nZ+KC8P3hdN42OCjehv1iEyndy+RqmlKBAkQdwkalNy8r
	 B3jQ8zaoKDq43u67Fx0K5V10KiwZVQl4ilAcimddK5r7Fo65ig0D5lngJQ2NIMqgY3iF4
	 bMInn45LkPB4uLQrfvQRFdrp52oBg06v6jZjbmR0nASA3qCUxjypUru/X/2LOniUtXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Faprzkg6fWuPAvDPMXDs7xk+PBjqYZ7BOB85tMAo618=;
	b=XvNKEUZNnvNA1O1lGPEIbx2tIsPHT4HJx3fhBqrQq+LJQk3qWtaWMw+DrGmVp8KThuvT
	 9AWd1vWskf0IZIxSy9v9Ubjv7BSxyYJip+dBeUP124ck/WqYXWAo96fi3WeM9n2QUrSt9
	 iC423FgC7EgaKQs4dTxtHVuiqiGAZ0iaxdpXX6XQlMQEy44SZHuIprNmeWorIcPsNRNIy
	 0xTqtNVux3T6EI6mEnXgm3AggbHEUXb/0lSPBZzGkqvgxJsDcxXCB7756UurRpMZhrVlW
	 vEybbWe614/bAG4AqxA0XdRMEo6nxre760Rhcr9U8OO1syK6xuBqL9WeVxa8iNZ2Jkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uvs73N0p;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072BB606A338
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 03:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 072BB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uvs73N0p
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so4704953eec.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 19:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794367313; x=1794972113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Faprzkg6fWuPAvDPMXDs7xk+PBjqYZ7BOB85tMAo618=;
        b=uvs73N0pqjTjkgtlsNddop169hBs5NczvKcImx6xE5AyWuz51JqbAbQ+GrPDvgmCIl
         q+7Z9arn7JwI2xm6l1F+JHTX7SJa5vs58q7/TWk1RkRGh1FkMIwJy+ebGukPz/WW2Hp/
         hR7VBkML8xQ4+4YLW2bqFG7HbE7qMYnTKF2WqfMyOr4OfkIe5tYrDQco3oJMEqZ7iRYT
         lkYepcHs0uZknCOXliZNoeTrdjEMh4lpHhGfxmlUsBJ6DZMQnq1UeshT97/XavD6KbC1
         XQRW76kjlWiYw9ZTFFWExWtJevo3Bt3LhooHy9bk0l+9Mc0Em16qV9gJBwNabWkvjCO3
         Y6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367313; x=1794972113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Faprzkg6fWuPAvDPMXDs7xk+PBjqYZ7BOB85tMAo618=;
        b=qNO9R7OJk70JXZb5TSnYc9aTSlj8Ev7msmLbbpZelZuUS2b/LSo9MbeGFnYn+VFR4D
         qfT+MfiMXwymI3F3P46AuKEzxnPDgBhobr5nXCOJRubXM99NbZ0m3yxZx07/PHmC/316
         036SFOve0TAJs/BQsEguAueSxzBp6UizsRQ93MsiNpPHxM3XG7CoLDvnnuBhvr6HEnDQ
         Lg9Qnu+GI1H0t7CMxT2VuyYFczcio0g18PZ/1d1kVs6KqdawTn6+QJ7OVGWO5TwmXZ0k
         J1FI3I6lhFDCM/p4mk7xDaTciXIDA3qoSEI9xg43A2vIrZN7EH4VP9vakno/Z907W6BW
         GEmg==
X-Gm-Message-State: APuU4Z8yPRrKFiUPWCXzombpaKFXoYwjaop4Qjupdfk9SO/yeApUOzEv
	Kk/0krQb7G7jc0GvZwVP0wOpOudPH0xX5bA7gZ88bLwwUrLsW1HEoMFrGbJFKg==
X-Gm-Gg: AYBFou1BLMi3BKlEtwrl5h3QKzG0o5ZoSrueeV7njlWeVZKCn+cuZIjefRpMxlRcKxU
	MI3hxDP+Gj+RJLJah2y3h8A56tt8y5o3Id9/YkEqCmCCu+9WuNu/k3LPJ8jdjeHaVzte71sRhSB
	wGGkMBI+bYRHMAakgwWvOfOqwXfNMHWwXm8gjwAyTZgll0/cXxTummVZkjDq90BM0Puh6t6VeSM
	oTp2F+CZfAAdsxlOeXk/AdjITjUVK6CEvhghNzgHoF2NfT4NEDqUYyW68KbE17UelSP6F7yU6eo
	poG3l5KuKT78iN9FfZKFvfzNfn6/HKPh8KcPdeMb5K2n/ZpdERmw7N/Cc7R2RBJRTdk4SBfxCVH
	FgT5bWOfvq2k+upO5wFcFemIhAklAtT8rvrIUmKeoxcweK4UQ5AuFp1uzRKqZumnoWoFHr+ocsg
	m6heMaKl8/TRkOBIgcs38961quuhAFfRanpHfGGunlZHcJ2f3SbMdm6IdRE0VGn9CAFJhsf/jth
	Ee4Oe2hig/emRLggdY+kQraYrY8C/zFFtd+9NJp4Wsa7NHzu5QbnsSEkAI7uJtFVnx4wOdxMc01
	uWSK9jd3anugiQ0fxij5eYRu7XliFGnA3zCrO1eQQgLMy1PCERzRM2KnsSWx6Cs=
X-Received: by 2002:a05:7301:906:b0:35d:4185:5395 with SMTP id 5a478bee46e88-37686171e97mr2082971eec.16.1794367313086;
        Tue, 10 Nov 2026 19:21:53 -0800 (PST)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ad6f11csm9801896eec.0.2026.11.10.19.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:21:52 -0800 (PST)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [RFC bpf-next v3 1/3] bpf: Add KF_CHANGES_PKT kfunc flag
Date: Tue, 10 Nov 2026 22:21:39 -0500
Message-ID: <20261111032141.525444-2-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111032141.525444-1-thisseanzhang@gmail.com>
References: <20261111032141.525444-1-thisseanzhang@gmail.com>
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

The verifier invalidates packet pointers after a call to a helper that
may change packet data, see bpf_helper_changes_pkt_data(). Kfuncs have
no equivalent: bpf_is_kfunc_pkt_changing() special-cases
bpf_xdp_pull_data() by ID, and the kfuncs that write through a dynptr
are listed in dynptr_write_kfuncs, because the dynptr type is not known
when the arguments are checked.

Add KF_CHANGES_PKT so that a kfunc can declare this where it is
defined, instead of adding another entry to the kfunc lists in the
verifier. The verifier then invalidates packet pointers after a call to
such a kfunc, like it does for the equivalent helpers; a stale packet
pointer kept in a callee-saved register across the call is rejected at
verification time.

The same predicate is used by the CFG pass to propagate the
changes_pkt_data property to the callers of a subprogram, so a kfunc
called through a subprogram is covered as well.

This is needed by the PPPoE encap/decap kfuncs added later in this
series, which adjust the skb like bpf_skb_adjust_room() does.

Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>
---
 include/linux/btf.h   | 1 +
 kernel/bpf/verifier.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 87fad4076..0ec8b939a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -83,6 +83,7 @@
 #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
 #define KF_PERFMON      (1 << 18) /* kfunc requires CAP_PERFMON */
 #define KF_ITER_RET_INDEPENDENT (1 << 19) /* next result outlives the current element */
+#define KF_CHANGES_PKT  (1 << 20) /* kfunc may change packet data */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20b1b9ff5..62536bb98 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14411,6 +14411,7 @@ static bool is_kfunc_dynptr_write(struct bpf_call_arg_meta *meta)
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 {
 	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]) ||
+	       (meta->kfunc_flags & KF_CHANGES_PKT) ||
 	       is_kfunc_dynptr_write(meta);
 }
 
-- 
2.47.3

