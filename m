Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595C33AD85
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098081; cv=none; b=OL7rCWYH6O66uGebDKWtsw7GYqc/5rAaPcaTPkxWYYetZza8ABJBsiaIYhaq5WM5N00OTW5MOK2YPRc0EUAuo8cSVVmPgQ89x5OFs//qrXsdTOxjYNiePVdc832rdzblv/2HDhJ6pyE3XBPY8qsZ9Vunso3FYS/R3sswi3EsrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098081; c=relaxed/simple;
	bh=MnN75VDRIjOzQ8aQhpnXjb9fxmvgBajrVNq586v1XRQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GXvZBUNDUuUXyDrI5JxqDUKNFZ/Hikt6FqYLq/FETFDW81v77siph4WElVpt82RloCdPQq6Y9o2OFJdtYU//vEYO1px1H7pW8uprqMT128w5YcmsGefsAe9Iju3XlHFHpDvJrwVKokA3ICIphy3U6RUXbtZj0RjHUxO6XexlCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYYtbj/U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYYtbj/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E36C2BCB0;
	Wed,  6 May 2026 20:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778098080;
	bh=MnN75VDRIjOzQ8aQhpnXjb9fxmvgBajrVNq586v1XRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fYYtbj/Uk8yeFI13tebHCVa0WYdF6eDov77dS/e0HSmyJpU20s9DRNszCJjQg/0ap
	 hsp/dUrM2GugIYD2uorLTk/I7LjV7QCH44YocH29mk+WsLsGYJtILM2bcHBuKS5oZB
	 RIMJHhEdnCYmuc4STPh2xFMRYHMpBQ3XfRJTrgNUc73PyVzQWqPiIc6ZLhAGWr7S/y
	 zVZelq5aYrzNUxUtMzvt22RUJgm5f/N3ca+hCawXKnJR5x7Pmm6zjVPv+YGfdZCF2b
	 NmHcaY6xP7CH8W1kRdY0EssTdCOQFM0X/8m3rHkFmagyntiH5jxsRSuSEh8oo8v1U6
	 5eeh8moBhP1Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] selftests/bpf: add tests to verify the
 enforcement of CONFIG_CGROUP_LSM_NUM
Reply-To: sashiko@lists.linux.dev
To: "Paul Houssel" <paulhoussel2@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506131257.713895-3-paulhoussel2@gmail.com>
References: <20260506131257.713895-3-paulhoussel2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:07:59 +0000
Message-Id: <20260506200800.88E36C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Resource Leak (Memory and File Descriptor) for bpf_link objects
- [High] Logic Flaw preventing graceful test skip on unsupported kernels
- [Medium] Test flakiness under concurrent execution due to global system l=
imit
- [Medium] Test failure on kernels with different configurations due to har=
dcoded limit
--

commit 18126ecb98cd2c651e3993d4401ade44b2577a2f
Author: Paul Houssel <paulhoussel2@gmail.com>

selftests/bpf: add tests to verify the enforcement of CONFIG_CGROUP_LSM_NUM
   =20
This patch adds a selftest to verify that the kernel limits the number of
concurrently attachable per-cgroup LSM hook slots to the configured limit.

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c b/tool=
s/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
new file mode 100644
index 0000000000000..1c5825c6c3d07
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
[ ... ]
> void test_cgroup_lsm_num(void)
> {

Since CONFIG_CGROUP_LSM_NUM enforces a global limit across the system,
could parallel selftest execution (e.g. test_progs -j) consume slots and
cause this test to randomly fail?

Should this test be renamed to serial_test_cgroup_lsm_num() to prevent
concurrent execution issues?

[ ... ]
> 	bpf_object__for_each_program(prog, skel->obj) {
> 		struct bpf_link *link;
>=20
> 		link =3D bpf_program__attach_cgroup(prog, cgroup_fd);
> 		if (!link) {
> 			if (errno =3D=3D EOPNOTSUPP) {

When CONFIG_BPF_LSM is disabled, bpf_cgroup_atype_find() returns
-EOPNOTSUPP, but __cgroup_bpf_attach() translates any negative atype to
-EINVAL.

Does this mean the test will receive EINVAL instead of EOPNOTSUPP and fail
to skip gracefully on unsupported kernels?

> 				test__skip();
> 				goto out;
> 			}
> 			failed++;
> 		} else {
> 			attached++;
> 		}
> 	}

When a program successfully attaches, bpf_program__attach_cgroup()
allocates a struct bpf_link and a kernel file descriptor. Since the link
pointer is overwritten on each loop iteration and the skeleton destroy
function does not free manually attached links, do these links and file
descriptors leak and prevent the cgroup from being destroyed?

>=20
> 	// CONFIG_CGROUP_LSM_NUM set to 10
> 	// -> 10 programs shall be attached
> 	ASSERT_EQ(attached, 10, "at least one attached");

BPF selftests frequently run against external or distribution kernels. If
the test runs on a kernel compiled with a larger limit (e.g., 20), all 12
programs will attach successfully and this assertion will fail.

Can we use extern int CONFIG_CGROUP_LSM_NUM __kconfig in the BPF code to
dynamically retrieve the actual limit instead of hardcoding 10?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506131257.7138=
95-1-paulhoussel2@gmail.com?part=3D2
