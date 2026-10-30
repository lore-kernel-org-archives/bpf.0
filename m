Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793321362;
	b=2glIPy98eO35RUKQv3fNeX5YydQCEL0seO2mHQVenWh7OGKlilk9TDjS3O3YFxa16fHq
	 mlT6C6Alz/wsicv3lJswvcS083udrjxDdhwM6r7AYJOrcurRngl275k3vtj2z+NL0msx5
	 bUXmEbgvOnIjueDEWKthDF/BbIp2himlriOOIDG1qix6JT1x9i8z7gYwonZEs97gZwlDB
	 Po1ECneC/jvKpL7BgCkhYM2IuojtL8S9N2zNEnLqo5vWEG9m51UqmIfFyr8s6CGX1a7ve
	 H/t0q9xb3AIe0Ubg/UXGtdFPjuhq2kkC+g7GAyuoZK7EmVJTt1cwABhRh7EWuzqun4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=t9Bmho/2eiUgmDCVdKSiojvfYHYLG+Fr/08JNYPiiik=;
	b=pK61tsSAWbOkFXgHGekA3NQOXmKhSJqAgZE5MKTm3CDE2r1TpppY7N+7xnb9lAxnGqO8
	 P9ruSMy5PXZT2KJ52CSxELL+27Y9cmoSmLhiyS8epUcsCthPZQHOwOpmbkFlFYE3+kfVH
	 vBTmdPVY4OD9LruAhiarsYHKp7FXFrvbeWp4ozd96lZTN9j1zIblRZ7r5LpYg6XkRoVZv
	 fBrQRTmG9VGh38bwOzEYW1yhsHlzaiXdNltwqbA+SUJbgtapIjTwC0r/Iy1z7/4YlDHEP
	 JBBTyygesF7zEWSBreMetEqkH9IjXLeVfoQIEZtBVtFKGyiAmCT8bYFxilQtFWeOYNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bv3AHppu;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D9606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 00:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 069D9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bv3AHppu
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b0d91601bdso11316017b3.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 17:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793321361; x=1793926161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t9Bmho/2eiUgmDCVdKSiojvfYHYLG+Fr/08JNYPiiik=;
        b=Bv3AHppuIWGTR6BF5QaUfVXSv3GE5B4uy8687xg41/mXvBwxJ/sH7qXRbr6nwNZubV
         TJ/N0SegvY4HRNZuWwiwi/5BFyeHxKTLm6iSwFqlv9BNb/i1zhPyLsg7LH9CFRO0DByy
         sOoLcy00Cmxo5pbnvPFaLvBnFMmpPZ/tFtLnPlTuSnUq5M53lJSEqMjlVuUQd4IP4FBE
         5l+G07305eG99P9pd2oU1bUe2MgiuPJwQkR+VUVwMLn8WwdCrx8rvtLbV9yMdu4jqsOW
         uyiA8NaE/ubJPyfwaLhCWnXMoSUsPNo7eo94JedJzL8y6W+6v8CrrdT2NYRVmJUHmkFh
         Q9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793321361; x=1793926161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9Bmho/2eiUgmDCVdKSiojvfYHYLG+Fr/08JNYPiiik=;
        b=Dv2b2+iLzNhzjIdAviYiWn84fiIv6X0bPORR/eiUdExbmtrCUDckESMFnQrguCxyhy
         b0fFMcU+BHishcKuXU9xbkajOHTT/kXt1XmDbh/zUMcV43k0hE/3DYI7TajBB8uBAomt
         qiXrXl/+p3TlU3IBx3vt+WZS26ooLNjwMjdb+LKWRzMGq5woXkPYwaEoQshymRa69In8
         FZ2IIWTjSAqvz2oVC6qzeh5xOzdyOyZndwQ+VaYysIOu17qBUjjeh8+FDM5ZAD3477an
         oCtB9ZoKFIKjkP1hojZ4bt4KCExBvr7wUfKKeIYDvp102uXJ/242rX/guTEfEEAywFe5
         vg+Q==
X-Gm-Message-State: AFq9FYKNz7Xl1Zme2SGYHuDxFFeGHSA0Vdz22doDm1HEaVibG2lT8cJh
	ECKcHwI0jHAIBKW0FplaY4uZ7qVaeX2FWq211puxue8/l4AsmFK5USpQ
X-Gm-Gg: AYBFou1hpgRzTUrSHuBwxOO2XpRv/5mUQalyJZRL8rjTdBXu8NNKWH7KT/1zuTQ1ORl
	ZxdBCpz8QI7/7f/R9yJblMYo8pG4jaVnCgdJPTu5EnE/p1wDLuKNsciATXc+6C7/PNYVcvU0zDy
	nBNGe+jTmHINRb4HPo120c+y0sJa7bu91TDgn1WZ3bwl5Znk4W3FbHfJ8ZzaIyfdFdNtIUBF3q6
	0BG/688e4UwOHCx3e9SjNBjlgkaE/lcoHT+O8Q5aTBIgbRfo1F0tLdbVeGUa2ZrrCKyYHuZsEYQ
	22gTY49/LjalmePYUteHfYVYSQv1Jpr/nmgsFx7fA9WIaseWo8AX1CJOhlJddw1h5ZcsCQb22rD
	XgKhbRbRr7+XZA/dXC9a/6QDL6BCSjO1OZJL3NWCj7+R/0QIUjx/jQrhbH0wUGCqlcrP9qQ15OF
	VAaS27HPrqZrzsGsUn9L24KfVUk3FThz2az7MRv6nyCOoGWSs4Z8k2RLF6birO8vf0GawOQ2PE2
	YnQxmtW2dDCi/eUtH+MvL4XF24yheWIm6SyjDEfAHgwlM3LwjFpLayUg9Dp0qWnWPseZQtOF59r
	eFDWjk9JOHZFmyRkBeMb3e9vILQvEzVqM1bASf5N
X-Received: by 2002:a05:690e:4854:10b0:677:a948:8d50 with SMTP id 956f58d0204a3-67ba4f064a5mr400440d50.14.1793321360962;
        Thu, 29 Oct 2026 17:49:20 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba756cbbbsm139597d50.22.2026.10.29.17.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:49:20 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 29 Oct 2026 17:49:10 -0700
Subject: [PATCH bpf-next 1/3] selftests/bpf: Check the strobemeta variable
 read instead of its location
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-bpf-selftests-branch-order-v1-1-425cc1ef8581@meta.com>
References: <20261029-bpf-selftests-branch-order-v1-0-425cc1ef8581@meta.com>
In-Reply-To: <20261029-bpf-selftests-branch-order-v1-0-425cc1ef8581@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 vineet.gupta@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793321356; l=3724;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=tCpvK57zK+MAMMIJ7n8zc94JY3VyaPwpR9jdRNJGtLw=;
 b=LB+5O0d0iAJUFLosKnAcyHQaQRYCi0XSduSQv7yyWPsjTV3Ct03nyr7vi23E9DYuOU4/9rtUQ
 mbbN47x8fZSBbRsGJg3gGdJPP+22WrxIgl32X9sp4GEFrWzFA2OBzk0
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

With an LLVM change that lets the BPF backend reorder conditional
branches [1], strobemeta and strobemeta_nounroll{1,2} hit the 1M
instruction limit. calc_location() is inlined, and the compiler copies
the "if (!location)" check after it into each of its return paths. When
a copy makes "variable missing" the fall-through, the verifier first
explores all later variables with an unchanged payload offset, and the
paths that read the variable, with wider offsets, can't be pruned.

Check the bpf_probe_read_user() result instead. It fails for a NULL
location, so missing variables are still skipped, but the compiler
can't push the check into calc_location()'s paths. Mark the read
failures in read_map_var() unlikely so that the fully unrolled program
also keeps them off the fall-through.

Verified insns/states, before -> after (fail: 1M insn limit):

  current LLVM:
    strobemeta           v3   163591/4755 -> 170708/4780
    strobemeta           v4   157733/4779 -> 167288/4896
    strobemeta_nounroll1 v3    55975/1708 -> 50165/1617
    strobemeta_nounroll1 v4    50745/1728 -> 49286/1656
    strobemeta_nounroll2 v3   115445/4341 -> 116942/4267
    strobemeta_nounroll2 v4   108121/4306 -> 109775/4210
    strobemeta_subprogs  v3    53647/1611 -> 52413/1771
    strobemeta_subprogs  v4    51204/1573 -> 50749/1795
    strobemeta_bpf_loop  v3      2624/217 -> 2695/214
    strobemeta_bpf_loop  v4      2632/213 -> 2668/210
  patched LLVM [1]:
    strobemeta           v3   163591/4755 -> 170708/4780
    strobemeta           v4          fail -> 167813/4892
    strobemeta_nounroll1 v3          fail -> 51250/1755
    strobemeta_nounroll1 v4          fail -> 47480/1796
    strobemeta_nounroll2 v3          fail -> 121092/3969
    strobemeta_nounroll2 v4          fail -> 117302/3708
    strobemeta_subprogs  v3    49653/1693 -> 51831/1548
    strobemeta_subprogs  v4    48305/1649 -> 44104/1577
    strobemeta_bpf_loop  v3      5017/398 -> 2815/225
    strobemeta_bpf_loop  v4      5053/394 -> 2792/221

[1] https://github.com/llvm/llvm-project/pull/236189

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/progs/strobemeta.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index 6e1918deaf26..584a68248764 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -366,10 +366,9 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
 
 	data->str_lens[idx] = 0;
 	location = calc_location(&cfg->str_locs[idx], tls_base);
-	if (!location)
+	if (bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location))
 		return 0;
 
-	bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
 	len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN, value->ptr);
 	/*
 	 * if bpf_probe_read_user_str returns error (<0), due to casting to
@@ -400,11 +399,10 @@ static __always_inline uint64_t read_map_var(struct strobemeta_cfg *cfg,
 	descr->cnt = -1; /* presume no value is set */
 
 	location = calc_location(&cfg->map_locs[idx], tls_base);
-	if (!location)
+	if (unlikely(bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location)))
 		return off;
 
-	bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
-	if (bpf_probe_read_user(&map, sizeof(struct strobe_map_raw), value->ptr))
+	if (unlikely(bpf_probe_read_user(&map, sizeof(struct strobe_map_raw), value->ptr)))
 		return off;
 
 	descr->id = map.id;

-- 
2.53.0-Meta

