Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7D53515F2
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727319; cv=pass; b=A8H8d8psGQq4kiUa57ZRMoEDmBOSjSw3xYJwxzetJt5AeJFmsp28LbfZa3pagU3+tRL/deKNV4xL7k+U64EQLySCv4LzlzoeN7Nhyde6tGyM1ALut2HGBTitg2PwcFuU8AqilT/lxN7EpA+6ajx/IpvkasedqkF3OuhwS4qEibE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727319; c=relaxed/simple;
	bh=XmrD7po+qWlEjJrFKCWclrfr4C0b1O/uuTaCBqXcQM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OloZ94jwsxxkTSKlWn8Ctyx475k+K961lqUzl3fuR49OLfiHQV6WFrA2PPjFcF+3HTVoJsQpn2L9j/U4IbOcmUKRsl/KhwW1yAZ2bMhXWyz2loq5IlmuveL9k5xUMJB0fvv+YfZAdescgunwIEZ7xOz9xTpo8mvF5ngg7+8+IbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpUp4Ela; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpUp4Ela"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aea0fff535so3220473e87.3
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 20:21:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785727316; cv=none;
        d=google.com; s=arc-20260327;
        b=fCiypmlNJeoBl39a/XLn78+CXRO5bK5Xyq4w0h/cZI1mCW2aSwFDJO7GBhn8VEPjoN
         rbK3mQyfWLxd4VoSiCKj0iGueoYWuCJBQG3VB81Jtve/h/nZvyDOCINrGXuWoN9F761j
         JjeSBDXvseKil5cD+cyKGdoAauk0GW+/V/nWDIr5rQhfKtO0+Oc8ekfmtU4CRNskS8Jn
         ZbDmhc8dnkGXZD8xjK9EGk4t7qowoYu0ZvbMu3V23ysJErHRib4Ca76xGXAAi/AMrijk
         Y6MQVQf3m8LwhFUGItJDhEpDmWxkl/qbRquWR1pFuHZbF+a8DVlGPR4tEXLVr+gr2euf
         zFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4eaJkWqBYFky8ybWnIgHxBVXwUECVZTbdZzi97smpQw=;
        fh=6kUPJ+GxVgkMUEPRCVk9068npD6yStNJr5jsFlmn7Fg=;
        b=r2cFEAqJpBJrxgV1RMMAVfZMq9CTT5IAbQApst1/BeY7Al6qIK5UTPK+Ynw6VuDL6P
         Y+M2F2kVoDIhp+HeVG/bdPUWIg3UdyoBI4oC2p4nLLCa0o2wBsfrMiPB+FFG/a5RXlaC
         bzfdDkdrlsHN4BstF0Pb16AzI08DcjR8CYZH12btzdjRnZZOhYvfPjAWG925hOYhkwUO
         2Bhs+lkRoQXfeXR4/7AdnDIXvWXttr1j8NVsjkrheF2k/GHzt07zuGgTJzV+ehCkChDL
         3I+bes0EC/73t5fwolz1z4XehlrYVOJlpxETzd/Tu5NQlhxdGs4UlmhurctD1z6h91Cf
         RxSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785727316; x=1786332116; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4eaJkWqBYFky8ybWnIgHxBVXwUECVZTbdZzi97smpQw=;
        b=YpUp4ElaMF0/z+0RVxCxc2Dh2oQ4+mjEg6DlXaoE/ybjhRpv/tCDBTaG80d0X/lE6Y
         8FnK/6cHDjz+CscQCpJX0dOreZeev6NbTG4S+xVkkUyZWng5JCGRMDo/HIjaCyNq2Fxb
         qIh+qmy6qw1nGORNTmYQSgyWoDMTK+VTZBrynlpY6SyMcojwhWKNk+DKxhiWR0SbncQU
         tbs1IRilw1bdrylnD7Lp11EKGD4l/zj+Xt5ul1o2J7zWgKbJe352ZL39ktMLEg7ke0SL
         Jg60hHZ9P0yO6vF7x3vu4+sAcWWgy53NMtUHaLsB77yAIx+qqEOm4gKeQr6u+FWA9yLp
         zNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785727316; x=1786332116;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4eaJkWqBYFky8ybWnIgHxBVXwUECVZTbdZzi97smpQw=;
        b=momJDMBVyLv/qfWAi3xjls0Z7vNwwTEoredHBPCagvweL4nuHKUta6EstF1+ruiAgp
         6AQvprNvHrlO4yhBIPRUJO39bDVB9hQgqRCq7JlIJxC8xJE22E1OkeoUagcZLbT2ztnX
         kvyrX/u5K1SRK/ZGLENO0EN38HtE/0JcvURgLrX7WsOiWM7o9/wGZ1Z4btFPoo2jA+j6
         oQIidjHoM07jE9fh8PNCqmIWzOQc+DqBHZ1Lxkka852P7QTFqH2wTB+FsTYdP92p8Zrq
         +wPYOL7zGCuNNxw/1nWJTT7PFZ9xmEYwrBdh8ofNgy3XlYkYLRxW6arj7zFj9ZoKRkRE
         XRgQ==
X-Gm-Message-State: AOJu0YzvqOH+O1UJF9RjpR6tsO7Zi4SHp3fa/a+AVukUdzTB8zU6eRyz
	peLHudaQHfomfB2Ete5aGy1fT8JPe5WLioxl0L2V3zrjDW1pPfY30On1HAwGp1+8HsE4ZJTzdnk
	sPIPPHXfvvr1Qf6C/ZC7Ep/2jz2NNBlM=
X-Gm-Gg: AR+sD13YJWYBfwCR5t+hQkiJXQ5GvvNRLueVMGwzzSGOZzaZhEvEGcql7NPT7uISalZ
	RwXOI7gvupPWhNpvuMbxrKMfZZbagIAEewBls+8D6gAPJA+YVlXf8019dSJp6th2I95ZLfDNH5b
	Ff4x/RsN2cofbH7QgvZLLqaek81VJLUEUbTEUfYVYnCqvUcfSuWTZE/TOiPAwCYwwi0k9fvB1yx
	y1xXAcF3769eT63VDDhNRDUL1YgLDMboysLLoLIecfVp1qnDCR8rQbGijDZT5122PBkmvu6/eZT
	C0nQ87J0CVKKbDuaVPyP1YbwZRdpeyjxzL0Qh4n9spsh9Ow=
X-Received: by 2002:a05:6512:3771:b0:5b0:1a3a:6680 with SMTP id
 2adb3069b0e04-5b2e4f6fa8fmr1032391e87.30.1785727315981; Sun, 02 Aug 2026
 20:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726021304.97ED91F000E9@smtp.kernel.org> <20260728033837.1466123-1-dingning04@gmail.com>
 <DKEUME1DRKOR.2R2XVNQDZKVSR@gmail.com> <CAJP4iuumoLdD62rXf=3HexiKVoKbXHJka7tm9+Cw-LaKmuvC+A@mail.gmail.com>
 <DKEYIUKP4IPQ.M7KVG0KIIU1E@gmail.com>
In-Reply-To: <DKEYIUKP4IPQ.M7KVG0KIIU1E@gmail.com>
From: Ning Ding <dingning04@gmail.com>
Date: Sun, 2 Aug 2026 20:21:44 -0700
X-Gm-Features: AUfX_mzZawoHHKghOtMZtV85ckhlcsLiiuKPTiIuAxYTUKnhIgGLy4E1y70NF-M
Message-ID: <CAJP4iusjn58Uo7uE8NzicZQmKoips9fu8+bV0jEJFUNmXz8K_g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject writes through untrusted allocated pointers
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org, 
	danieltimlee@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Second, I don't understand your explanation. WDYM by "after the access
> permission check"? It gets invoked for BPF_WRITE, so should be rejecting
> res->key = 42 if 'res' is a pointer with PTR_UNTRUSTED flag set. What am I
> missing?

The direct write will pass this earlier permission check since
type_is_ptr_alloc_obj does not check PTR_UNTRUSTED:
if (atype != BPF_READ && !type_is_ptr_alloc_obj(reg->type))
         return -EACCES;

The later PTR_UNTRUSTED branch is not a rejection check. It means when
accessing a pointer field through an untrusted parent pointer,
propagate PTR_UNTRUSTED to the child pointer.

if (ret != PTR_TO_BTF_ID) {
/* just mark; */

} else if (type_flag(reg->type) & PTR_UNTRUSTED) {
/* If this is an untrusted pointer, all pointers formed by walking it
* also inherit the untrusted flag.
*/
flag = PTR_UNTRUSTED;

}

For res->key = 42, key is a scalar, so ret != PTR_TO_BTF_ID. Therefore
the second branch is skipped and has no effect.
