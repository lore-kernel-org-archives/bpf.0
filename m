Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55532860B
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803076; cv=pass; b=NbPJ+snZ6mjJJgBSA3bkZVF3SIw2Mweapezn4B+/SVRtvWvyK05vpAYMNas+3jepY7Y9UC15zqpjQPvGbIYmnIvB+NSyJ+E2v8/HVeBqW0q5473Ys2VUXKWRtRLn2Hs+CC3/OGuYRuVwGBJXQ0t/Jjeu2VASSgSytrkNj2LE/sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803076; c=relaxed/simple;
	bh=v+BYsnkv3rolZ2kAzt9tXFVKPORPdSqggBJhLyE4crs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pz19lPgt/km+vQxJ3R2I3X1HjET6jLt1ixQhZMlVSmCoGQNMsLYuIGt1SA5u6A6dAmqc/pUNnqkJjYew2kcjzp3o/kCqZ+BzGXt9XG4yzSPGQtGyfiBbH3zCHJShTcxVElC5Vzj35JZBxQs/l/A/rxY1OQJ//DAZbIJwD820FL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqPLwTTG; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqPLwTTG"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso3126833f8f.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 13:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776803074; cv=none;
        d=google.com; s=arc-20240605;
        b=j0oZdxa/IxWmYxeRFWMRJ5Z+UlsLVg1xOwbFZOGDYt1ulnUDmlpHtI5UJS3jxFE8kP
         n0sz/9IrLWEDgI9XmNSYWEJIr+CxtC+pePILbhbPQw+yotgofQMVkylaWjBnJ/ZhdkPr
         QfVkLKfCSyD058xgxdpmd1Xbny94j9oZrVhFe/2sD3UNSMRgMH58+dJcePCOStGxvE7h
         8woOaS62jLVI0bI+fjDyMTNxM8+NAVqaK6lGpyoC94CTtP1g9CU+maGUmhrLUnif4i9x
         wn4kuLg9cJ8WklGhHgbbPXxrA3UKt7TQO0HG1qqYouKPrgWY7Ti3lB7CKkE6tV24CHwJ
         heoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Hu7amaW4BFaWrVkYFZDPhGKfF4GconZ4wvndCgCyFSs=;
        fh=1uNWLdpXngJp60bqJOtI34s5d+/7bGwl2M2iDGSoq3Q=;
        b=JZCeVXUO6VJ86J5JSBlygqszWiKQa6f2gm2QTUhCvfSu5HipOTxCktyl3tNZjss8rE
         Rh6ACUa+WLyMbiPN9W0q29aFN7m+KGa2HKEdH8rQkRAyU47jqRhmMR5rW/ciEeQdJHbo
         GX5wIoA2dImSqM4zX5T2nHaIxr3TL2lfwFe4IzB/i22BCxIiP6UEQPuWuphAtmhc+ip6
         gDdWSWAnjG3R1DZ9OsbG3fJ10EV5eABIPg3ZfweZJgQHccZD0ir8nTxpyVuTejFs9u2h
         HAKuPOLa8aiazPWSPE61Q/qQqWjiBtJEtrnjFwrDKpRUyCDILApSQwA77FdZrMSAbsU1
         bfmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776803074; x=1777407874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu7amaW4BFaWrVkYFZDPhGKfF4GconZ4wvndCgCyFSs=;
        b=mqPLwTTG5am8r/0jcIRXAr7nWgvURC4s78KKT6zU07uEuwCqWRU+/eNfuQRHxalKqO
         DcoTUAouL3Qyt5F0pGWYsa6qn+5/G/+VWBAlf5hEO8UV8n127cMCzu1zehHk/xt3Y6LK
         3rN6hXCAgEiqoeAW3czP8LXdCig7FRK8Ae4yN1R7AxW2BddLR9MgyKIOFOCXhUToAzuo
         VPphLXxzu7qr3mzeQ5bcy0dJYZtV40zsk8KLAA5p4OoHT6bCYea0SzpWfc4MrVkjxwV1
         uGJBV8SN3CUNLpC26Cl+141/d7KsVv/Rk3RdXQIUSRN9sqBMfPw1RvFnOFtJyxCp6o5m
         CQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803074; x=1777407874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu7amaW4BFaWrVkYFZDPhGKfF4GconZ4wvndCgCyFSs=;
        b=lKguwLejmy3/kTXmt00Ah7JY8GFVP4ba2rnnfnuAjYTc3JrdEzfUQ74/Arfbhc+kwh
         gXfoK33rvtK5vsvPJQbOjL2ZDsMgKzVffOQ3M/IOxumUZD9fBjdqSEjOdYQcCWAIJMYt
         RVegRYfUnWh0DN3GjMrN/dnM9tCKd4H04txvT06++K298pLFCw2bouxtDcibGuYDUrEA
         xtASjlbMv7oi51FyohregKRZpn132+fdsCP8WODgYCwXHKbW2QbEYyKMB2NLV0zIpO2i
         anBRzbBTWX8SbKgiozEfnRLNQjWPz4n8szMTMN8//3Ec4FCF4abLvPMAiyswDKy3lYE9
         D19w==
X-Gm-Message-State: AOJu0Yxs1H078rcFifw3QFJe+rU61ZBEHkmIuCl0jpkTJQZsA7q1YsAL
	qcroOdQazOI0f0gxuehi6ZAY5kJ1sIaoxP+4KMKfznIGCniZkFz+0oP2+fMhWvareeo+NX4eFVV
	CMwHxhnIRIztY/DuPGuMSRD2MNadpciQ=
X-Gm-Gg: AeBDietlRclmIUcDBhUdvCsTA/4ucOHycaQytsV7wSdv6yUCTrWYIuOVo6n0sMiC1Aq
	3tPqMX5mkSue1TI617NQqj2u4O4HGaF+an+SzVIkd5ZQeJuGHiu+kP4IjBCrPKAkBQ29hyU7to1
	YKYjhVUzcarF4OizHC8ppRTQydFE5J0OrXFjVkIbLz8qE7/TaAH8kdAEVo715WJLqsz7qtPDi6m
	QrbG6PeO0fzaVdZ46sej6tAFSwqDOE6gFwpNJ843vNFFRy9O1iG/DCCCgny3Bq5lM7yoMq+1mZo
	7+mPEFvai+KBJ2G9IrDXHP2RqgoZtcn2XrbQcREB6xf+eNmVeW6Gvxlx1+YxRsLyM9ovJ4+WXMe
	kuunr+Ym1WMkjzFsWH3+NSRJiZGioPv2anKQClKFYiauJ2mv54MBBAVmv
X-Received: by 2002:a05:6000:2502:b0:43e:b0f8:c564 with SMTP id
 ffacd0b85a97d-43fe3dbd756mr29518976f8f.9.1776803073499; Tue, 21 Apr 2026
 13:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421201035.1729473-1-utilityemal77@gmail.com>
In-Reply-To: <20260421201035.1729473-1-utilityemal77@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 21 Apr 2026 22:23:56 +0200
X-Gm-Features: AQROBzDny-JzFzO9_4b2Ak8kakoDnMijLVGq3AF_tfZhqvs7HDOOmMTicyc4GDI
Message-ID: <CAP01T77FND4_i0fB8zrYPJj0HAx=CkvTFB4=eV4EyZbdpuqgow@mail.gmail.com>
Subject: Re: [BUG] bpf: Soft lockup / panic triggered by bpf_task_release_dtor
 from NMI on rcu_nocbs CPU
To: Justin Suess <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, 
	yonghong.song@linux.dev, jolsa@kernel.org
Content-Type: multipart/mixed; boundary="0000000000000843b8064ffe34f0"

--0000000000000843b8064ffe34f0
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Apr 2026 at 22:10, Justin Suess <utilityemal77@gmail.com> wrote:
>
> Hello,
>
> I found a reproducible soft lockup / panic involving BPF task kptr destruction from NMI context.
>
> It was found after further investigation from a Sashiko report on my patch:
> https://lore.kernel.org/bpf/20260420203306.3107246-1-utilityemal77@gmail.com/T/#t
>
> The issue is reproducible with a BPF selftest-derived reproducer that:
>
> 1. Stores exited task references in a BPF hash map as refcounted task kptrs.
> 2. Deletes those kptrs from a `tp_btf/nmi_handler` program.
> 3. Runs on an `rcu_nocbs` CPU.
>
> In my setup this eventually triggers a soft lockup and panic in a workqueue thread stuck in:
>
> `perf_sched_delayed`
> `  -> static_key_disable()`
> `  -> arch_jump_label_transform_apply()`
> `  -> smp_text_poke_batch_finish()`
> `  -> on_each_cpu_cond_mask()`
> `  -> smp_call_function_many_cond()`
>
> The triggering condition appears to be that `bpf_task_release_dtor()` can run in NMI context and reach the last-ref `put_task_struct_rcu_user()` path on an offloaded RCU callback CPU.
>
> Affected code path is a dtor triggered by deleting the last reference to a task_struct kptr:
>
> `bpf_map_delete_elem()`
> `  -> htab_map_delete_elem()`
> `  -> free_htab_elem()`
> `  -> bpf_obj_free_fields()`
> `  -> bpf_task_release_dtor()`
> `  -> put_task_struct_rcu_user()`
> `  -> call_rcu()`
>
> This is triggered from:
>
> `tp_btf/nmi_handler`
> `  -> clear_task_kptrs_from_nmi` (reproducer bpf prog)
>
> Environment
>
> - x86_64 QEMU VM
> - PREEMPT(full)
> - `CONFIG_RCU_EXPERT=y`
> - `CONFIG_RCU_NOCB_CPU=y`
> - booted with `rcu_nocbs=1-7`
>
> [...]

Makes sense. I think the reasonable path is to just close usage in the
NMI context, otherwise we must address each case. Could you try the
attached diff and let me know if it successfully rejects kptr usage
here? Thanks.

--0000000000000843b8064ffe34f0
Content-Type: application/octet-stream; name="kptr.diff"
Content-Disposition: attachment; filename="kptr.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mo92msha0>
X-Attachment-Id: f_mo92msha0

ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYyBiL2tlcm5lbC9icGYvdmVyaWZpZXIu
YwppbmRleCAxODUyMTBiNzMzODUuLjVhNjkwMzQzMmNhNCAxMDA2NDQKLS0tIGEva2VybmVsL2Jw
Zi92ZXJpZmllci5jCisrKyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwpAQCAtMTgwMzcsOSArMTgw
MzcsMTAgQEAgc3RhdGljIGludCBjaGVja19tYXBfcHJvZ19jb21wYXRpYmlsaXR5KHN0cnVjdCBi
cGZfdmVyaWZpZXJfZW52ICplbnYsCiAJfQogCiAJaWYgKGJ0Zl9yZWNvcmRfaGFzX2ZpZWxkKG1h
cC0+cmVjb3JkLCBCUEZfTElTVF9IRUFEKSB8fAotCSAgICBidGZfcmVjb3JkX2hhc19maWVsZCht
YXAtPnJlY29yZCwgQlBGX1JCX1JPT1QpKSB7CisJICAgIGJ0Zl9yZWNvcmRfaGFzX2ZpZWxkKG1h
cC0+cmVjb3JkLCBCUEZfUkJfUk9PVCkgfHwKKwkgICAgYnRmX3JlY29yZF9oYXNfZmllbGQobWFw
LT5yZWNvcmQsIEJQRl9LUFRSKSkgewogCQlpZiAoaXNfdHJhY2luZ19wcm9nX3R5cGUocHJvZ190
eXBlKSkgewotCQkJdmVyYm9zZShlbnYsICJ0cmFjaW5nIHByb2dzIGNhbm5vdCB1c2UgYnBmX3ts
aXN0X2hlYWQscmJfcm9vdH0geWV0XG4iKTsKKwkJCXZlcmJvc2UoZW52LCAidHJhY2luZyBwcm9n
cyBjYW5ub3QgdXNlIGJwZl97bGlzdF9oZWFkLHJiX3Jvb3R9IG9yIGtwdHIgeWV0XG4iKTsKIAkJ
CXJldHVybiAtRUlOVkFMOwogCQl9CiAJfQo=
--0000000000000843b8064ffe34f0--
