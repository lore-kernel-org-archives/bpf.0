Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E12DCF6C
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776546004; cv=pass; b=bzybuReLXqWIpsP351tO5Mf/0kMxjp4HHSmZqskvgmUPgt1walfYdE+MMF4wkPoFxf/1m8ctHfdMd2iP33HytJ1W6S3jm/WknJapZBbF/ljsH0pXRS8VwEbo7nkP2DeN9BGFa9bPeF+bLE4qgJ78b//4B1foKO1zj0UitwCpviE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776546004; c=relaxed/simple;
	bh=otR+0uIsh1RGcAJvbjgadtuvVlaOvwcem9nCzBdotGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9epgB9j6v0CccqQ+CcE094+APnxpBSDxjZ+UoFNjU0FLLt1UseCm59QIWH3BZ4SeC+tJ5IEs6OgKWxoj8VC8LkD7buJt5JWtBZcjN92VYR/mFuuQjeTMkyf2/s8dC9KBYEASEam/OSmK97tx2aUkPk0WLT98tU3uqUpK0QNXzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWrTMfJY; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWrTMfJY"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so1141450f8f.0
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 14:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776546001; cv=none;
        d=google.com; s=arc-20240605;
        b=aKTmPxFJsaNx6NKK82s7aZwtBlL3W2A0fFUE/rULywORzfl8NT+L0LAMpgkDGc7irE
         m9csdFJHUEU/kJypjO19W8YPeAm0jsdCrHTNYUL8/ulyvdJvWjboU5wcoFzBTkyfCjUp
         BOEWAGHifKVCjQOqxnpR+sBnFBfomLb2wBLBdaCIv8NjHdoxnk7CY/SnVG6ly+0VP3aZ
         IMRvY9jUM5D2e9mrSth/GFNtUIdl1ns8Uo4mYu8rABzUSoVdVO0qhdjN7lrIoeaoiCyg
         MAtnLIG67h0BJ+mvynTzbS5+yo/KYhrgkaujjUzeh0Zq8UBG655lilgI+BqbQIpcKYVi
         E+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4hP7GmAPXuLcIJddQKNmWXWlH2vIU+tAuH/qZAjzeQ0=;
        fh=zblyZrDBxpdN6pL+9otm0S5RJ68xoocYmmuuoEd++SA=;
        b=f7Wu5WrMYxMyByb5Tc4vmLfFd2llqP7eCziw/hzP7kpM0QTfaXSw3iiceGxGivmUch
         vAfBNnirzH6WHnY1I5lYoMzgLmTCMqDV6POpeO/1Bkt7nwPdJMcwmUctlWyZAkfBf38w
         o/tCSx2+03+al7Vg/670Ua/3cJiVRSn/5iTblFjO7LbnTVjqH5QdaqfuWG6GpoQLMLRV
         xnbq8ZxHACS5e8+Ql7tRQlOXV+FuCs/N/NOkJan7/l58QiF1+kCxSotEgNj8es7ox4Zk
         WQtZQr1z33tBPDXDxwATEfe8CowGkkKdpE0ZdaHvlinYq1GgX2SnMekl0jdYKHOC3Ghp
         mTsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776546001; x=1777150801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4hP7GmAPXuLcIJddQKNmWXWlH2vIU+tAuH/qZAjzeQ0=;
        b=GWrTMfJYj4Y8v24gSJCp9uyqVtE9WRahKtmcmTWI4GgSWO9XCfGdyWRPoK0ftx8spt
         rLrAPhLhsVGKWmXnKoAMVe0HD4WzGTqgpI1lUF3BHyJaPIgNg9h9FjRirQlzWSPiGoA3
         7cjyszNxKMNZbtspOS0XQiQX6XVkCTHI+wCK3EMSFtfTBlARiICXNS67rp4K4OPXF2Xs
         b8gpl91GQFMcRuVhm/uMhV6ICbpOnLo9HdBIYN3/ckZpONuboWaTk1/L/y9xcmtDKNgD
         zltte/0IP0f8w/mrLZr9hv2C2Ll0uM4tsUknRxx3kDifD/tyP3guhR27Un+Fo7UR5IgR
         5DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776546001; x=1777150801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hP7GmAPXuLcIJddQKNmWXWlH2vIU+tAuH/qZAjzeQ0=;
        b=HVm5RRzFjQMS3P4V/x+UiIAR7ULxdv0oUK1F5lC/A1k8+TCTnB/5V2ju5QobIgQYYf
         xy8mEFB5PiKa6ONZ0yYrpRIMz8zch+T9nyp2LrhzwsFuhJLxUjvJaUmDVSEOfAV/xq3O
         LcpjF03LJ6PJplgbHViVvdl6Qpi3n5Dv4JyoWUKdcJelCFQ0y1mISf0yWCc3DsqOkw8H
         2H4GUyPxijRz+it5Q3PYh6YZQbEn9a92LFaP2SUOYfdClt6UKKcRa6hf+Ryz6oSFa7jX
         NDYmwtGH59mK3Qa1L2RQINhP4Djlte2wS9+tQbOlAElZzPeik11Ai64xx2UWFBT73dso
         z6kg==
X-Gm-Message-State: AOJu0YzLSeYmqIPX1Jr523CDvQ82cAlnnSDMa5vZQfy7a0zz4Hj38I+z
	3uGc4S5iT+sAu9tQGmYdIFrvmAkRXGIj4yEpwQhmSly/7pn+auLvWHwxDmgjDVhtOfH6pd9T7aW
	gIZ3rw78nKPJB090+QtGBBzwDQLw7xsc=
X-Gm-Gg: AeBDieuXeno1SML6tTqMRd6fiIWJCLLn6fHUP4cvD5Xax61noDMQOhPwyV1MNuWTdJm
	69zRF6zYx7yuIBMPGkqedJtsCRtDCEPlD1m4/x2LQz9msSKYuYusUGcmoiKISKTbgCnLKbSWyvk
	syfVHxMzYAHGHWVxKZDN+WvdihLk7RZQI+V75y4I3fj7GGeZXgp67eHIxx9P8MUCSW0kUrHNp0l
	7936xu8m1R4HpoyFWxTopPiQl2al021kKI2GVUBbI9QXGfvA+C3pdFDPfeUonCb91A6kSHZ7jj6
	16UxhLjUvUHYcpGsqm0jK6nlW0P6TRmOVR6ORFj0Rdh9NbWEFTOEeYsz58hTSnkKFiH2SZt51aG
	VGxLrjcOG8o+vwZidbZGklH8EZRRp2QvHJaH4TRYs/gl8iPHX5p4=
X-Received: by 2002:a05:6000:2890:b0:43d:75ec:26f7 with SMTP id
 ffacd0b85a97d-43fe3e08f96mr11884719f8f.29.1776546001072; Sat, 18 Apr 2026
 14:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414191014.1218567-1-ameryhung@gmail.com>
In-Reply-To: <20260414191014.1218567-1-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 18 Apr 2026 21:59:22 +0100
X-Gm-Features: AQROBzCyiIlogAYg3NujVMIxH1AeXIFjwOtU3t2f6D-0ZK19k4NTcKkw2VyTik8
Message-ID: <CAP01T75TZ85xmd3HKeK_+o4WOMj9xTgg189qkJMygBzDLLjofw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/1] bpf: Refactor dynptr mutability tracking
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@kernel.org, 
	yatsenko@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 20:10, Amery Hung <ameryhung@gmail.com> wrote:
>
> Redefine dynptr mutability and fix inconsistency in the verifier and
> kfunc signatures. Dynptr mutability is at two levels. The first is
> the bpf_dynptr structure and the second is the memory the dynptr points
> to. The verifer currently tracks the mutability of the bpf_dynptr struct
> through helper and kfunc prototypes, where "const struct bpf_dynptr *"
> means the structure itself is immutable. The second level is tracked
> in upper bit of bpf_dynptr->size in runtime and is not changed in this
> patch.
>
> There are two type of inconsistency in the verfier regarding the
> mutability of the bpf_dynptr struct. First, there are many existing
> kfuncs whose prototypes are wrong. For example, bpf_dynptr_adjust()
> mutates a dynptr's start and offset but marks the argument as a const
> pointer. At the same time many other kfuncs that does not mutate the
> dynptr but mark themselves as mutable. Second, the verifier currently
> does not honor the const qualifier in kfunc prototypes as it determines
> whether tagging the arg_type with MEM_RDONLY or not based on the register
> state.
>
> Since all the verifier care is to prevent CONST_PTR_TO_DYNPTR from
> being destroyed in callback and global subprogram, redefine the
> mutability at the bpf_dynptr level to just bpf_dynptr_kern->data. Then,
> explicitly prohibit passing CONST_PTR_TO_DYNPTR to an argument tagged
> with MEM_UNINIT or OBJ_RELEASE. The mutability of a dynptr's view is not
> really interesting so drop MEM_RDONLY annotation for dynptr from the
> helpers and kfuncs. Plus, if the mutability of the entire bpf_dynptr
> were to be done correctly, it would kill the bpf_dynptr_adjust() usage
> in callback and global subporgram.
>
> Implementation wise
>
> - First, make sure all kfunc arg are correctly tagged: Tag the dynptr
>   argument of bpf_dynptr_file_discard() with OBJ_RELEASE.
> - Then, in process_dynptr_func(), make sure CONST_PTR_TO_DYNPTR cannot
>   be passed to argument tagged with MEM_UNINIT or OBJ_RELEASE. For
>   MEM_UNINIT, it is already checked by is_dynptr_reg_valid_uninit().
>   For OBJ_RELEASE, check against OBJ_RELEASE instead of MEM_RDONLY and
>   drop a now identical check in unmark_stack_slots_dynptr().
> - Remove the mutual exclusive check between MEM_UNINIT and MEM_RDONLY,
>   but don't add a MEM_UNINIT and OBJ_RELEASE version as it is obviously
>   wrong.
>
> Note that while this patch stops following the C semantic for the
> mutability of bpf_dynptr, the prototype of kfuncs are still fixed to
> maintain the correct C semantics in the implementation. Adding or
> removing the const qualifier does not break backward compatibility.
> In addition, fix kfuncs dropping the const qualifier when casting the
> opaque bpf_dynptr to bpf_dynptr_kern.
>
> In test_kfunc_dynptr_param.c, initialize dynptr to 0 to avoid
> -Wuninitialized-const-pointer warning.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
