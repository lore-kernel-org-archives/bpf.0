Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067688;
	b=ynZzDVd01uPzy3i1S5m4sXaOIzFa4RVRDjwXvI/5HZoV/eyKerPhhCgW3a2jNzNKs3T/
	 Ls9Wn1aTJW7HsuG2XahiIsPVwMy+3n6F9bWTsP23dEdxX3LbfnQKf/C6JFyQBQJ38oLeT
	 U0x2dRWeUEWl0mpN18wMqG3KyxOjcs41JM3KtuwMpWuUS8fh1lRVZRSQOSSyVAT6/A9fK
	 T9vC4l+ayfsrlF/D7NVRVaGTP2BjiqKYf5PsfTzNjOhhrLuMakp310NlV2x2tCDJuHuf1
	 4phRtbTXRjN/6xbzk2+rwVrqPhhmty8slMSR50ukQmDjAKkzkCjkk6sPh4HyZOfNHgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=2wXXFuTcJDjo7rR6+VPIW5IMj/+AQeeJztZyV7rgklI=;
	b=Zg+GHpTckIdVHUBad+ZKAgkRYyzvpv4tDEA/iZHzamolTEOaPPBzZzgS4atnnYmUhXqO
	 aWWz11lItYSHUc7IZQvAraLQV0aXrAUE1ogK5ZIifstBsddEZap8Gb30R0vCrgsXpDBUh
	 kGuyrLzq+lJs5yWqU7dy8aIlYXqy6FZMC/GBgLOpkbVAuci0t0YblB5BZWGs34BF43YYu
	 0rzu0MJVWWmQjv/Au8T0eqzkAJcIg/iI1CbINHkn+UycGo9n824+f4T1+rp+1QAgrwoFO
	 z6OtEuWPm5KCBeh73TtXc0FhXaygNvZPkR49NiZ2XIj26HFWszM3eJt67evk5rTg8Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNjfbT2K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF44606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF44606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNjfbT2K
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-92123971d1bso5798996d6.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 21:54:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067687; cv=none;
        d=google.com; s=arc-20260327;
        b=g7dFW0Drwpj7zSk7DyMa4bJh7lbyHQmKG55dpLLZxcDFIV97fJK56AlZAASpGgWpEs
         9VSHE1JyfPcPzjlB6+2SVC5/mNsTZPElyB1q6Ua3Tl4xlTDInJzq/zpZqUgbb7gJlEWo
         343tPHje38ab1PYggX2DKBHn3S7syxOkpriA6z17s8sGKroO9KAOCmWzPfFlZrv2FaRq
         90s+ukWDp/se4j9bPbJUlflj7JgygpmCoscvSeB4TUUxg1Ry+36O3/mL0SvrIUjSV6SA
         213J3Y69j4ETS9t9sEI9W3OwOaJ+D9MnH0s7hTru6+Z7drMEwf1IEGz+UICOjQTTgmMB
         qlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2wXXFuTcJDjo7rR6+VPIW5IMj/+AQeeJztZyV7rgklI=;
        fh=hh64WXw32xDCPRIwo8kqdpPDKtEO7rcNvFi6kTS088k=;
        b=iM+A2K1ZtD5EJRwIE1VD2yWl94hoKzRxj97/v8Gc7Dkn/rnNG4tX7hbTlISCZ5SjBj
         CInwOEbkBpdNdhe25enrPjci2kYz82MDkOSJtKzXpSsON7DmOm1hy3Ge8mQ/X3bFH+aY
         3xtJkl05SfBkIQ/Bx/G6SvjqlB7eewG7nInQWnj7+90xLjqwtFJ68ebplkzJy1Mqkzga
         PAvA5vM7N50ZqroLSM2m5/L9f0ktfKl83YXAXw1ggO+YpkjBgNzDVsJ6lnn5vcFN7sAo
         3oZJuwBNRbKteK0H8R6qEuDiNzEgiJAnB68zW/12IFIY1cTJWhpaavYok4++7vmIv7/o
         U0DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067687; x=1795672487; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2wXXFuTcJDjo7rR6+VPIW5IMj/+AQeeJztZyV7rgklI=;
        b=kNjfbT2KsYxh9KCeLeMMebhEDcSBb0PkAblsmhHIBjncr887FqFV+zOuw3Q9hKQULI
         y2yg31MFE3AMRDiLMbzL/BgdMbLbZ7KNo66DpXaXFh9/vRy6VBDfFChIQOp9/gngmOTx
         DCRtDRQey5Sk5V4Vdbg7oDx1rOa5cg6A2HczTwf1Wz7RY6heL53a1pPOXio5lES/pjHU
         E5O2dMRy7GWpCH7TkvBqbVKP8lRDcqla1yHNrtuccSuJ4cAhP9nQpuB6wQnDQHCjt/j7
         7WU6+/u8rLgfFNRB+t337D9wyhmjTPO7mfN4Pdis4fccWtOvtRtgd37W8zfXOufJXKBh
         Um2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067687; x=1795672487;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2wXXFuTcJDjo7rR6+VPIW5IMj/+AQeeJztZyV7rgklI=;
        b=nKUco0573xGwuxI/Km76LVgqRwpua5uTWnki7VwKZFXvduGRQl7lLsx7x0NsbzmPMh
         5vMxS9B3gvIu097q8NouQw1doX+aOQV/uDBhMzVYQzvAyJSbiVWykzDxghltV2aHwSzL
         HtqUoEmzhJ31f6TZXbX0m2Dfz6zN1T5aRfZDTfux+wQdGthBLsWVVMcqgwabAY9KSQDX
         Flv1o1FefB+FQXQE6Vt9xBh0fg2IdMo4kibOz7qBNoKpdm9dAqTVGGpuWWATRM3L5s7r
         daKPqKKjSg1EfXjp42/npPEFLvM1QU994CeVh/BrGjwBMiucL6plz9nwm4FfsgX3km9d
         v2IQ==
X-Gm-Message-State: APuU4Z/trA/XnzREe+6TqvqPAVtpRY5TuTWzFUml+90ZWjTSLfLthahi
	1WnlUtR8xHUYi+y6FHb0d9WyiXYwXBrQScWauX24IobsDm4HDtZqUj/ecu+LjTzNGmR4lZen0qa
	J/GVtlpJXic9kt+AMqHMVa2+dyQ1iv8Q=
X-Gm-Gg: AZFdTZdjlyl+AWePV1VPsOeoOegKtigyFjkR6SnWO84ntcF4eWimxb77fALrxUegsUI
	h3usZvlGxMN/CUdjTXRl76kMzDGcsN72sW4MUtSX1ki8NV4D5NvWDyV1qvvVzh9KBPmnqwfiM2d
	ji9nbgsSwmFidiXKae35zU6PyqeWS3y2BEs2Ov7g4viktLUHN2OAF8e/TRj9Pjvhed0sUsoZVhx
	XuhZKWW6X0wvVcTOUKOVV8XGVOhNzFIYfizz+SmHSD5Gh996UGwv2/oCazwTfUSzVUQ96IthD1l
	GitfORbj4Rb8RlViAoRqFc0kOdiSbaFo8eUkbwyencqdR6dKxAZCGUey81cyiPnv+aFaJ4hSOFi
	mRqzMs5Udlhs2218yf55wQ+wNra9zH01dCE3LouZeCKD4cn2503evR2Wy56aFi8XPtEleQs5bud
	Rokx6APYRkOlKUz6N8OKE=
X-Received: by 2002:a05:6214:c26:b0:921:2a5a:658a with SMTP id
 6a1803df08f44-9212a5a6752mr10383876d6.54.1795067686707; Wed, 18 Nov 2026
 21:54:46 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 00:54:34 -0500
X-Gm-Features: Aa3M54rooANSh0wfNk0OqAvnMXG1PqYBJ6QADkFC7Bv_KtJPFMbNTbyXd-BP-YI
Message-ID: <CAMcAce_2g8TiPUZVkexmxS3A3YoAFy5Tm_87nXUGWW=z+gW37w@mail.gmail.com>
Subject: [PATCH 6.12.y / 6.6.y] Backport request: 802eef5afb18 ("bpf: Fix
 memory access flags in helper prototypes", CVE-2026-45903)
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stable Maintainers,

Please consider backporting upstream commit:

  802eef5afb1865bc5536a5302c068ba2215a1f72 ("bpf: Fix memory access
flags in helper prototypes")

(assigned CVE-2026-45903) to linux-6.12.y and linux-6.6.y.

In both v6.12.118 (kernel/bpf/verifier.c:9403-9414) and v6.6.162
(kernel/bpf/verifier.c:8870-8881), check_func_arg() passes
`fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ` to
check_mem_size_reg(). Seven memory-writing helpers still omit MEM_WRITE on
these branches (bpf_d_path, bpf_skb_fib_lookup, bpf_xdp_fib_lookup,
bpf_snprintf, bpf_snprintf_btf, bpf_read_branch_records,
bpf_sysctl_get_name), allowing BPF programs to obtain write access into
BPF_F_RDONLY_PROG read-only maps.

We verified this on a live x86_64 QEMU v6.12.118 test kernel using compiled
BPF programs (bpf_d_path and bpf_snprintf targets):
- Unpatched 6.12.118: verification succeeds ([LOADED]) and writes into
  read-only maps.
- With 802eef5afb18 applied: verifier correctly rejects with -EACCES
  ("write into map forbidden, value_size=64 off=0 size=64").

Commit 802eef5afb18 cherry-picks cleanly onto linux-6.12.y (v6.12.118) and
linux-6.6.y (v6.6.162).

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Signed-off-by: BoBppy <inkxiao12@gmail.com>
