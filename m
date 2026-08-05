Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA73ACF0A;
	Wed,  5 Aug 2026 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922185; cv=none; b=qVoa58lUQnROLqtjwOwfDxbP6iWOfuw6+i03ab/g/fw6L+tei3JclYf8msiEaj+K+kZYmrcU3yk6ZmMyzaPAzllXrDza+21oav3y5J9hPNYteqxc+dA9JdU+2aw30nmgUw+3JLSVNlFy6nlbWu3m6PONOm8zt4RGHopMAYkYsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922185; c=relaxed/simple;
	bh=gHpBMNGH9qpEXsum1B26mAX8iOcbFRjuSpqrenirLKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vufaj/admvSDWeMcQi9EgnbBXIcAGB9HjoS8Q2WOf1rIqPGo48qV+8mYnIRwjET+LjWFX0XJB/5lqK7h8lABcZE3WuWhzszeOt2Q23SW+3rBN7f/klkSaYtlz4L4Yo6eAXrtbgYO6FwE1Zf1cFuvnhu2alm9iIpQlFDqrnY1ZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZc4P6js; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZc4P6js"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0351F000E9;
	Wed,  5 Aug 2026 09:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922184;
	bh=vldBRBL5Z81fbzCrt18z3NiJ4+IPt1QY0AxHJtr+YOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZc4P6jsP2WqvEmmlEv38G0O5GwuOP/I8oh5fZZaGI7gNU5YqKrDwXU4Tiu8oiOeR
	 lKHVuyHvoVwDupzPZXJLV+KTq6JL7Sp1uC+saBHQadtrQqHbqgcvDQOFIui38mfweY
	 yXTtPSXq4uDffRdLe1YElO5bVE+KZchxW+QtsNwA9QV6CU8UjdGraHZuUom29V9acy
	 QJ4LbuygD5YCQaikrsukY/gVPevUr7NTPglXi3sIJebsTmoGhVrZqza4Vi+QqnkJGI
	 hSD9ZEXDX4NDqiZvO9aFPm11Imr+AKNeeOCZjRYbYxyNksHCQTCus3hSCMpwaA89qr
	 IiUsCi7oU9xVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add a test for arena
 fault-in under memory.max
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260805091720.139924-5-jiayuan.chen@linux.dev>
References: <20260805091720.139924-1-jiayuan.chen@linux.dev>
 <20260805091720.139924-5-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 09:29:43 +0000
Message-Id: <20260805092944.5B0351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test passes on unexpected crashes because it only asserts th=
at the termination signal is not SIGSEGV, rather than strictly expecting SI=
GKILL from the memcg OOM killer.
--

--- Patch [4]: [PATCH bpf-next v2 4/4] selftests/bpf: Add a test for arena =
fault-in under memory.max ---
commit d5e6a0b924679b20cf7f391518ec1a560ae725e3
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: Add a test for arena fault-in under memory.max

This commit adds a BPF selftest for arena fault-in under a constrained memo=
ry
cgroup. It creates a child process to fault in an arena and verifies it is
killed by the memcg OOM killer rather than incorrectly dying from SIGSEGV.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools=
/testing/selftests/bpf/prog_tests/arena_memcg.c
> new file mode 100644
> index 0000000000000..ca039ebd3d674
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
[ ... ]
> +void serial_test_arena_memcg(void)
> +{
[ ... ]
> +	/*
> +	 * Faulting a valid arena address until memory.max is hit must not look
> +	 * like an invalid access. Without the fix the fault path allocated with
> +	 * the non-blocking allocator, turned its -ENOMEM into VM_FAULT_SIGSEGV,
> +	 * and the child died with SIGSEGV on a valid address; now it is handled
> +	 * by the memcg OOM path and the child is killed by SIGKILL instead.
> +	 */
> +	if (!ASSERT_TRUE(WIFSIGNALED(status), "child killed by signal"))
> +		goto out;
> +	if (!ASSERT_NEQ(WTERMSIG(status), SIGSEGV, "not killed by SIGSEGV"))
> +		dump_memcg(read_cgroup_file);

[Severity: Medium]
Could this mask other failures by accepting any signal other than SIGSEGV?

If the child process crashes due to an unrelated issue like a libbpf intern=
al
assertion (SIGABRT) or an invalid memory access (SIGBUS), this assertion wo=
uld
evaluate to true and the test would silently pass.

Should this explicitly expect SIGKILL from the memcg OOM killer using
ASSERT_EQ(WTERMSIG(status), SIGKILL)?

> +out:
> +	if (cgroup_fd >=3D 0)
> +		close(cgroup_fd);
> +	cleanup_cgroup_environment();
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805091720.1399=
24-1-jiayuan.chen@linux.dev?part=3D4
