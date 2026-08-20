Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D419395D86;
	Thu, 20 Aug 2026 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251352; cv=none; b=qenYFp1Rw8bBpZpKNQPRwa3s3Kzj3OKhqbQqZG5AvPCW6PXxEccvbI4d4ZuNziVhmctVdySwa1AOetgS18qn83iyPdGsBl8A0DjtOABYRUvR8SvNcruSOBVkETuG1ROtaTHDX8+4jiH+Hz2PCCrVALcyQ61hK1kMJbBxhDz9NKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251352; c=relaxed/simple;
	bh=RbNRiPiz6g5rVDofceZOR0NDHloJ3pSrF/HfzeU/f9Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=M+AUX+594SV9a3Abb6MqMxhaRvzVooZeGjKCnTO00VQdwAFQVg2uNGXWFCQzZwskLE2THWj2R+1VwBLo4Gr+5fsREbfKlcmkUBxfJe2qoyveMUK3TCC7SYOcgkeZPNxtuZK8wOcEb9zbzgS5Qn4ePKePZVMj9AnCltOudZaBVBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meWdqk1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meWdqk1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7531F00A3A;
	Thu, 20 Aug 2026 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787251351;
	bh=HbroSlgN6GJtwz9zz/Ki2k5fbll8gvlJgyXkpYx3h0o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=meWdqk1e0k5jspXnXg004XGNtnZleruKHU4yAAa1oOlSH8IJXVkbAozaFuY5g+4wr
	 saas7l6jaYUvCFLxYUJQIBaSo+Yvh8GYYDQ/IUXQYtMJc7rHsYPkRkc9LvoY6j0UlJ
	 QGY7ESzU7NbBxrFRjekL7x/DZ2G89jKM7Jl8459jnMSA7TTpZdPMwtqCM0Vq7Ex7VQ
	 pvqCvk2SjS9aS/8kHzRS9Kig9Xqvh+SRXdCO5ewgYAMIPxX+kCPOX4v2BjSI2NJ9Qx
	 skHhf4mra7YmxKGYhLOKBDVNy2tlMVEUzRYYSY9hqRyx8qhDUnPOg6MxZ16fI3beSx
	 6RUfIbLH9rKcQ==
Content-Type: multipart/mixed; boundary="===============8020047159908745968=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c7043ee1ffe17c6204bfd2f151109af394c65bea110a24e687d44f5556bf9407@mail.kernel.org>
In-Reply-To: <20260819024443.781764-2-tushar.vyavahare@intel.com>
References: <20260819024443.781764-2-tushar.vyavahare@intel.com>
Subject: Re: [PATCH net-next v3 1/4] selftests/xsk: add UMEM users refcount and centralize socket teardown
From: bot+bpf-ci@kernel.org
To: tushar.vyavahare@intel.com,netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,stfomichev@gmail.com,kernelxing@tencent.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,tirthendu.sarkar@intel.com,tushar.vyavahare@intel.com,andrii@kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 18:42:30 +0000 (UTC)

--===============8020047159908745968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 90d52cd76f2fe834a2cca6abb76d0ae53c96b8e5
> Author: Tushar Vyavahare <tushar.vyavahare@intel.com>
> Date:   Wed Aug 19 02:44:40 2026 +0000
>
>     selftests/xsk: add UMEM users refcount and centralize socket teardown
>
>     UMEM ownership is currently implicit. xsk_configure_umem() maps the
>     buffer, but freeing it is spread across testapp_clean_xsk_umem(),
>     clean_sockets() and clean_umem(), each called from a different error path.
>
>     thread_common_ops() returns without releasing the UMEM when
>     xsk_configure() fails after the UMEM was already mapped, leaking the
>     mmap()ed buffer.
>
>     The pthread_barrier_destroy() failure path in __testapp_validate_traffic()
>     unmaps the UMEM owned by ifobj1 while sockets belonging to ifobj2 are left
>     alive. With shared_umem, those sockets reference the buffer that was just
>     unmapped.
>
>     Make ownership explicit instead. Add a refcount_t users field to struct
>     xsk_umem_info and release exactly one reference per socket on teardown, so
>     that the last socket to go away frees the UMEM regardless of which path
>     tears it down. Keep shared sockets pointing to the same xsk_umem_info
>     instead of copying ownership state, so all users update the same reference
>     count.
>
>     Propagate UMEM deletion errors from xsk_delete_socket() so callers with
>     stack-allocated state can handle a deferred cleanup before that state goes
>     out of scope. The in-test teardown paths cannot retry, because
>     __test_spec_init() clears the UMEM state at the start of the next test and
>     the mapping is then unrecoverable, so xsk_delete_all_ifobj_sockets()
>     records the failure in test->fail instead of dropping it. A UMEM that
>     survives teardown now fails the test rather than leaking silently.
>
>     clean_umem() skipped ifobj2 whenever it shared the UMEM owned by ifobj1,
>     which was only there to avoid unmapping the same buffer twice. The
>     reference count makes that distinction unnecessary, so the helper and its
>     special case are removed along with the other ad-hoc cleanup paths.
>
>     Co-developed-by: Magnus Karlsson <magnus.karlsson@intel.com>
>     Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
>     Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

This looks like a bug fix for the shared UMEM feature. Should this
include:

  Fixes: 6d198a89c004 ("selftests/xsk: Add a test for shared umem feature")

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 4549358cc8c2..bba5e8d4222d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c

[ ... ]

> @@ -1508,8 +1529,15 @@ static int thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobjec
>  	}
>
>  	umem_rx = test->ifobj_rx->xsk_arr[0].umem;
> +	/* Non-owning view used only for TX buffer arithmetic; the sockets below bind to
> +	 * the RX-owned UMEM, so the handle, cq and refcount stay in one place.
> +	 */
>  	umem_tx = ifobject->xsk_arr[0].umem_real;

A subsystem pattern flags this as potentially concerning: BPF code style
expects multi-line comments to have the opening /* on its own line
(bpf.md guide), even when surrounding code uses the old style. The patch
shows the correct format in xsk_configure_socket():

	/*
	 * For shared sockets refcount_inc hasn't run yet, so clear umem to mark this slot
	 * as having no reference. For the owner (non-shared) the reference was taken by
	 * xsk_configure_umem; leave umem set so the caller's rollback path can release it
	 * via umem_ref.
	 */

but three other new comments in this patch start their text on the same
line as the opening /* (this one, the "Keep ownership explicit" comment
in xsk_delete_socket, and the "A UMEM that could not be deleted" comment
in xsk_delete_all_ifobj_sockets). Would it be clearer to follow the same
format throughout?

> -	memcpy(umem_tx, umem_rx, sizeof(*umem_tx));
> +	umem_tx->num_frames = umem_rx->num_frames;
> +	umem_tx->frame_headroom = umem_rx->frame_headroom;
> +	umem_tx->buffer = umem_rx->buffer;
> +	umem_tx->frame_size = umem_rx->frame_size;
> +	umem_tx->unaligned_mode = umem_rx->unaligned_mode;
>  	umem_tx->base_addr = 0;
>  	umem_tx->next_buffer = 0;
>
> @@ -1599,6 +1627,8 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
>  	ret = xsk_configure_umem(ifobject, umem, bufs, umem_sz);
>  	if (ret)
>  		return ret;
> +	/* Mark before xsk_configure so rollback can release the UMEM if it fails. */
> +	ifobject->xsk->umem_ref = true;
>
>  	ret = xsk_configure(test, ifobject, umem, false);
>  	if (ret)

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
> index 03753ddc5dcd..15d6fe2b9568 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
> @@ -4,6 +4,7 @@
>
>  #include <linux/ethtool.h>
>  #include <linux/if_xdp.h>
> +#include <linux/refcount.h>
>
>  #include "../kselftest.h"
>  #include "xsk.h"

[ ... ]

> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 7dad8556a722..5d8a29e7224e 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32400920730
--===============8020047159908745968==--
