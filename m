Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466432;
	b=WT6CodUELfn2obgHIfPGxLdOm/zo8WruAtOEk8ZRwROnlmymYOdwvBmbQdrQveF40qOH
	 ZefmfUflJMhx7fJS4OTvs3NdMTr8mW6FixFhfYQmTQGdNSNgAD/luJkbFtg3XPpQXlmcl
	 +JPnE3eJEWHBYL/ILHvOMcv64FzCojGJ1Xoqr1EKTPw87UMk6GDqQai5Ytl45wfd9vzHI
	 FSB0a1K/Vz0Bl7JrP9xgNCxQVoCxGNBK5pO3P6GYsOkgVq1TMzacbZtWM4mGXLfGrY9hF
	 akcBv+2tLWluExIrMrr0t1TevITgPB8FQj9y0ULkskuoNkaochm/dIWxCKg4eHGEJOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=PqeTs0OEdiP2uTtWFXvUGWh5yzCA93pDqS6ulQ6Xi/U=;
	b=HX+XeJBHyVNnfZ1TH9eeDpqUs7UN5qtoxCXUuLRrN9LSRKRyVxYoNYyWyGU+Zr0mTDIT
	 snlUhq8XFPHcIDJ3rOJhD+NnP8pS4k+A9+kMQ3NzXmbmW0r6QRnwXqFGCgqKfs+ZvUVX1
	 /v0Hu2t/DMqVSeqcJswCyt92N9GFy5L2RU3FN1puW40H33EQn1kdQjFsEcynZQ6qnHSHL
	 tgNwxLCIhOrtxcUHmATFc+BPgl+DshjAg0IqGk5FjzKPG8FNQaPM5zRIl21gKQy2IktgU
	 waAqgDnzBdKecgc6gUHomn2TLNyCpGoSXTFW9EdLvN8a+HukvtNVJG1tFn2RwmRxfuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vXIZK/vH";
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D09606A31C
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 17:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1D09606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vXIZK/vH
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so533503a12.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793466431; x=1794071231; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PqeTs0OEdiP2uTtWFXvUGWh5yzCA93pDqS6ulQ6Xi/U=;
        b=vXIZK/vH67BDbgcwM4Cb7hOXrAAAQ5hvncYeaLI3z0CprXTvfb0bHlhdAEOjnEFbCl
         kUa6hwsWyXZYiWpHlHfpW4332fM6P3EL0Vy8yzFjo7A2OO2EsiNRAAR51TOafHkLAg+4
         gfsSR5lmtLwMBuqd6Rs0FwvvZWaS9WdZWwN+gRl8GK50NlG2ESNM8BjH2CNvYAcXotXc
         1nXaMPS4oXjaDFBqYWkXU4bv9ZKK1gJHBhqD2CW/O6L9Nhg0H60yMPu9i+wM1eA8xjAd
         lb8zbaNI3El31j4+LPN8YXN9JcSza/Fc1mg4nPCdxwip24m9MHV4woYMACgRUD5GjChd
         Jcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793466431; x=1794071231;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PqeTs0OEdiP2uTtWFXvUGWh5yzCA93pDqS6ulQ6Xi/U=;
        b=Nhm13fsCsXDahEEwr5PlpoKtWXb3KBPGh8L32mAoWlSDS5AhXYpLYrHKTFVwACs1Tw
         atc5f11xuPRw7tg9DCUDdRLW3Da9n1kNUxCQ7NgJim1nnGQAtBNDm6nVjkxrYTq2V382
         pYA8UqOsi/QttVo4/fnvh6GhqNpO/v4JddzoMZV75W1yJKNodeMbi+21sdkPP/n+uCBw
         aaWOwuDbh7EH0eA8qt8mQm9KgkuBUHh+QGHYe6sKWMg8HmfZuzpSoD+5zCqq6wxpoQ75
         EjBSUNJg/U1YR4ab0EshnEz3UpEU5s9Mp/1njzgVjQKlPpDIeYhwdM2Cjx/eOawz9AoO
         +4Gw==
X-Forwarded-Encrypted: i=1; AKwUvBzWPEtRd6NZIf4nMjXDtrZ33fq/C6hu6eRZCYw2+sZJG8nWz3Mp1vOcTAYTfhF0A8jjpCc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPnEEgAaFGmjk73pXTjS7H506Ivurt+uV8jcKvBBL8FXqCybgM
	1r0nGyX6ovfe5bzIQezlsXE+V4RnYpOypdqpj5JgTKWjkd7OL15JKjZN
X-Gm-Gg: AYBFou1KPHQKVXz1BEAvTu0iPVZMro+qIArp2s+e9UxMdvd0VrK0LLgQ6yvFLQXXY7O
	FPTAQJPBnL9bq+ltqSGsg89UUWw1maTP+VrER8H9g2Pbd2fzpj1aKfBcLq7+VHMxqUG5wh+gcjg
	4sEuUrgofqZMfHyDyXFhlDii9DxCCdzVdeHOo7LpGvZ1FyQD7m5gLUiEQ/fkL7qM8FBImxQKTr+
	5xd0NJEV04u1jVZWQHDPjyVhKDUFQnw2Fv7UEj+/G03LXnm4mtN+oHofFKEeesOMlrkts7A3PCS
	49Wsg8HmlUiZ3r9D6pi6e2BZM9NQwOK2+bXJQxs93hb7Lgm17YGOud0z/z4aRm/wSoKQNMQvQ4F
	ivBXSKeTJP5wqGq9Rmg03wHWz/UZR0Y7oE/gGINBZroXONO7krq1ZPN3mJloEwlytKYfYeZkLa0
	QXhinBYN+iHmF5QghYjz90UxtfuZc4ac82kPgqas35IC0DMb6Mn9tQL3jMMPns4sMm1T6OQaZWB
	tH4wk+2fFuL0TM5IcYZ/toPZtEDlTJxfB+PfxxrIjkjzddqlLIHm1JWLhJ0314f/EjbrLWQf5vQ
	502P1ytKwpouR4LxtWV880mxRiqDw7gPO+CWM22Y1hpzlO1nlOEuGiiqmY+tKjShVXzjs22KJCF
	CAx/jb7S3bJTy7iXwmY6jCj5JCuQL90dwpg==
X-Received: by 2002:a17:90b:5145:b0:3ac:9706:772c with SMTP id 98e67ed59e1d1-3ae8984cefamr5029531a91.60.1793466430956;
        Sat, 31 Oct 2026 10:07:10 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9bc6f7sm12221824a91.16.2026.10.31.10.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 10:07:10 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 17:07:09 +0000
Message-Id: <DMJ6SFP2GD3X.1AW7OEM6GPY4Z@gmail.com>
To: "Jay Wang" <wanjay@amazon.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alan Maguire"
 <almagui@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>,
 <linux-kbuild@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 <linux-arch@vger.kernel.org>, <x86@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hazem Mohamed
 Abuelfotoh" <abuehaze@amazon.com>, "Bjoern Doebel" <doebel@amazon.de>,
 "Martin Pohlack" <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: Re: [PATCH bpf-next 10/13] bpf: defer kfunc and struct_ops
 registrations until first BTF use
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261031130959.23472-11-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com> <20261031130959.23472-11-wanjay@amazon.com>
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

On Sat, Oct 31, 2026 at 06:09 AM Jay Wang <wanjay@amazon.com> wrote:
> The first use can run out of memory, also only because its task is
> being killed: vmalloc() gives up then.  A round that fails with
> -ENOMEM, in the parse or in a replayed registration, is not published:
> the new BTF is dropped with whatever was applied to it, the queue stays
> as it is, and the next caller starts over (a struct_ops ->init() then
> runs again with the new BTF; the in-tree ones only look types up or
> store the BTF pointer, which nothing can use before the BTF is
> published).

can we do the first use from a work item ?
A kworker has no signals and is never an OOM victim.
Then -ENOMEM is as unlikely as in an initcall today, and an error can
be final, like without the option.
workqueue_init() runs before the first initcall, so it works at boot.
No need for the retry, for btf_unparse_kept_modules() in patch 11 and
for ->init() that runs twice.

Something like this (not even compile tested):

static void btf_vmlinux_first_use(struct work_struct *work)
{
	struct btf *btf;

	guard(mutex)(&btf_vmlinux_lock);
	if (btf_vmlinux)
		return;
	btf = btf_parse_vmlinux();
	if (IS_ERR(btf)) {
		btf_drop_all_deferred(PTR_ERR(btf));
	} else {
		btf_vmlinux_new = btf;
		WRITE_ONCE(btf_vmlinux_builder, current);
		btf_apply_deferred();
		WRITE_ONCE(btf_vmlinux_builder, NULL);
		btf_vmlinux_new = NULL;
	}
	smp_store_release(&btf_vmlinux, btf);
}

static DECLARE_WORK(btf_vmlinux_work, btf_vmlinux_first_use);

struct btf *bpf_get_btf_vmlinux(void)
{
	struct btf *btf = smp_load_acquire(&btf_vmlinux);

	if (btf || !IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
		return btf;
	if (btf_vmlinux_building())
		return btf_vmlinux_new;
	queue_work(system_dfl_wq, &btf_vmlinux_work);
	flush_work(&btf_vmlinux_work);
	return smp_load_acquire(&btf_vmlinux);
}

The undo has a hole already.
bpf_io_init() and bm_bpf_init() don't only look types up. They register
kfuncs. And bpf_struct_ops_desc_init() turns every ->init() error into
-EINVAL:

  btf_apply_deferred()
    __register_bpf_struct_ops(&bpf_ring_ops)
      bpf_struct_ops_desc_init()
        bpf_io_init()
          register_btf_kfunc_id_set()
            btf_populate_kfunc_set()      krealloc() fails
              btf_free_kfunc_set_tab()    frees all vmlinux kfunc sets
            returns -ENOMEM
        returns -EINVAL
    pr_warn(), next entry

The BTF is published. The kfunc sets that were applied before this
entry are gone until reboot.
