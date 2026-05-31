Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE16241C8C
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215551; cv=none; b=Y7vchUTTDBXw5ZAoxwSi+8cPJlhlCpp9MY8Yieqh5fbmQ2z1Kwk5XvZeVw928xB4EVbGRqyoAWyE975YHnz5yfGn1ZezI3k7XVPDFeCpvWUU+/kVlt41SmFuWBJmQmRiwj2QQmu+7RfOq37ByjazaQmcSjchngS5fwlt6aFdKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215551; c=relaxed/simple;
	bh=NnI7KtBcJHa7xdZCSNBJJTx+N5FMmXVKp7LlchXsBqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rNCTH6c2MSoDEPERiSKf3/xjnqPhYmitN9JhbzZRjxVucjiER933j/0ZgxWM82C9kcWFXs2emPEFCB0xhnoBR9iBRvgFMzBGzuDvZaZD+KzP1JS1W6FDYdGWEswrOap8reniy0p4870PURfzWu0igxhFttHWxcBuiTLZioHjcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBH5aUfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBH5aUfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43831F00893;
	Sun, 31 May 2026 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780215549;
	bh=s0IyJFwFgaR7dtficd91xtns8Qmb8/fUboGzcpidNM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBH5aUfyyYMrL3gu+htnvhnFciIIP+kmfXi76Jcfokko8l7QVGw7VuXYUAJcxFiXu
	 5538peIYm0kVi6UE1ptllFNDpUIFG0A29nRaC5ObmktbAIKgpnwIktMd+j6CBgEF4z
	 iAswIEww/ScntYu4sWs6fr2YgZhYW5C+ufAydZKJ3fVK+P1Bxs5zDP28q+XCe+8urd
	 4oPzh9lvRyA3UwOWoWzs+60ZdeNLEAq63VcISLVCNvTg9lfWeT3pfbLXQ1BG/xtIPG
	 HRvoAskZB6p0nY3Ns6S26f/43r4VT6I7or9WJl/VkOlhD3v6ZwUB++hLfmYbMJcpwJ
	 f4L2Jsnd5yymA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: add verification for
 BPF_PROG_QUERY attr size boundaries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuyang Huang" <yuyanghuang@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260531075600.4058207-3-yuyanghuang@google.com>
References: <20260531075600.4058207-3-yuyanghuang@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 08:19:09 +0000
Message-Id: <20260531081909.B43831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The BPF_PROG_QUERY command handlers unconditionally write to outpu=
t fields without verifying that `uattr_size` is large enough, causing out-o=
f-bounds writes in user space memory.
--

commit ff64a4dde49ac116fe47c4da225f078f2f7358ef
Author: Yuyang Huang <yuyanghuang@google.com>

selftests/bpf: add verification for BPF_PROG_QUERY attr size boundaries

This commit adds a new selftest to verify that the BPF_PROG_QUERY syscall
correctly handles different user-declared attribute sizes. It specifically
tests that fields beyond the provided size are not written to user space,
verifying backward compatibility.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_attr_size.c
> new file mode 100644
> index 0000000000000..32159dc64da8b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c
> @@ -0,0 +1,69 @@
[ ... ]
> +	err =3D syscall(__NR_bpf, BPF_PROG_QUERY, &attr, OLD_QUERY_SIZE);
> +	if (ASSERT_OK(err, "query_old_size")) {
> +		ASSERT_EQ(attr.query.prog_cnt, 1, "prog_cnt_written_old");
> +		ASSERT_EQ(attr.query.revision, 0xdeadbeefdeadbeefULL,
> +			  "revision_not_written_old");
> +	}

[Severity: High]
This is a pre-existing issue, but while this test checks if the revision
field respects the buffer size limit, do the other fields actually respect
these boundaries?

Looking at the BPF_PROG_QUERY command handlers, they appear to unconditiona=
lly
write to output fields without verifying if uattr_size is large enough to
contain them, which could cause out-of-bounds writes in user space memory.

For example, in kernel/bpf/cgroup.c:__cgroup_bpf_query():

    if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
            return -EFAULT;
    if (copy_to_user(&uattr->query.prog_cnt, &total_cnt, sizeof(total_cnt)))
            return -EFAULT;

These writes happen unconditionally regardless of the size passed.

Furthermore, in kernel/bpf/syscall.c:bpf_prog_query(), the central
dispatcher drops the uattr_size parameter entirely for almost all backend
handlers:

    case BPF_LIRC_MODE2:
            return lirc_prog_query(attr, uattr);
    case BPF_FLOW_DISSECTOR:
    case BPF_SK_LOOKUP:
            return netns_bpf_prog_query(attr, uattr);

This means backends like bpf_mprog_query(), __netns_bpf_prog_query(), and
sock_map_bpf_prog_query() never even receive uattr_size and unconditionally
call copy_to_user() on fields like attach_flags, prog_cnt, and count.

If a user application calls bpf(BPF_PROG_QUERY, &attr, 4), which is only
large enough for target_fd, would the kernel proceed to write multiple valu=
es
past the end of the user's buffer, silently corrupting the process's stack
or heap?

> +
> +	memset(&attr, 0, sizeof(attr));
> +	attr.query.target_fd =3D cg_fd;
> +	attr.query.attach_type =3D BPF_CGROUP_INET_INGRESS;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531075600.4058=
207-1-yuyanghuang@google.com?part=3D2
