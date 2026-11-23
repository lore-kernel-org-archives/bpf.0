Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434241;
	b=GTL+INSep+eA0M95nKZtFVqQccbkxvTCctLNDNzTmX+W/EKFJw1dEr5MMTezqyLQFY20
	 cKshQ2Q6D9qAlT8mvbEM4tmsldC5ErgXkRTmnOHAAiHhozNZBh7dCbWIFdorfazBDVYHx
	 u9c7k0oBJa2DOzpUWxIaj71SMCZv5CXWec6OkaxEKQvQUPyis1h59FZn6F/cE6uBWmM7c
	 JSuuK2U1S+N4IYXIJ2rH8n2AcdnyS5B0IKPx3rz42nAiYSJ3kdg7FfWqZU22vSXqu0PRN
	 rvwzZEGlfyhHIjJWLiDD+P540mqJMSYlWeFSym6dL91zXumfAyja6kPQKV5yUiUl+5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CUCPhF26O34G5hnc4b0my/OnjDHNH9LBcPnQRfSJOAE=;
	b=KokqoYbopQqWfKBtWXDvngpEj6GkWQW0Qxi0ndKfWYZ5QOgYv5oF80a55y0pfJeePg3y
	 +aqh5x34QjHGchQULtvwHq94csRHhQh+YyEIYChsKAWen18xzqedMNMBmlMWAHT4iUnG0
	 bYZ2wQYmw0ouUt21LmTfx/jd6oXZQJ2FLczQFt36uo1BytomgEBZSvrRpeOgq/ZEalRr2
	 FD6upoPaxnkGSz6QWcfdKVe3zspGvJw30OKHrd9ELFEwr4I5dma5FxEXgbB/dc4uyyw4T
	 +xIAMevwhC1TOzkhxQ13dB04RO/KzxKDn7G/rO5SATjKJcGj/ecVjizwTvFPTN1sSNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="UUvr4sN/";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE1F606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 11:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FE1F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UUvr4sN/
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-385c497bf94so1821893eec.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 03:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1795434239; x=1796039039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CUCPhF26O34G5hnc4b0my/OnjDHNH9LBcPnQRfSJOAE=;
        b=UUvr4sN/MtcnZrkf7SSPMNr/15ZxuOgbb28kzZqTuGqQ6LBtQ2ZdNerNQSKpHbc+vD
         D2jOHT1+NPxEkBdh29fuHfYcr5xI45SGAe3t6VudViVvTVVHzT8sgswoZCbfXv6H8ruT
         YSibo2KJHZpVRQonfAn/UYTRI8oHDeSgHUTZIfPzVssz1aLzY4MD0RJWcS1LK04/yvdQ
         r1ey5WaEGoHAM3BA1SgK8xdG435LEglsv+Z8fs9Ap+QPyyg9qwZBX8aq2ob2ZPwZggDq
         92gqK2X82bWDblJ2hcnLjkZzMCALia0f3DfHgkHm6u09MiZrBajP0/xvysUQIzG9vVN2
         ayWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434239; x=1796039039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUCPhF26O34G5hnc4b0my/OnjDHNH9LBcPnQRfSJOAE=;
        b=S83z1WeeQKDcqepdSjO0hXg0k3u+Md1CsMuCxFnvjfw0DP/ddbuCjckYsUFpdbWGF5
         CyqYr5O0FHaBtILWBdG2m0K8dNYhH6qYu4fLsh/b4a199QXwedqXJ1OYnmx/66OfVf6G
         o1dr7P6XpDrT0N5ScO9zHDIXJr4jL68UkSO3Dvt9uAmNLLjIJSZeeB746R7IbAJdDoMx
         duCn2aifB5dIZhYBkGQf5ftWG5xYNK+fAcA9+f6ty6HmZExmING0/lRYYLtW63/3y/dK
         yfZd04Gq1W7kKxyoP+PiGxYNQ9Oid5qL+BliInP+chRLxKZypWnlia/XnwErcl0vzG38
         238w==
X-Gm-Message-State: APuU4Z/aNU8BAgH/ktycdo9hURX8Lm/HW7rSM+HiOOKYuRG2juKFDEAi
	4z1kfPHnlK+OzfKx8rkcTQqwWJn8sBNmfrEYIiDJaqEA/2a1WoX+lnPC9uoyW6kSQaOM3/mW7lo
	g0qfSFIZ/
X-Gm-Gg: AZFdTZdA2yiO0OcnzAC4jrC1EqofgceLGYRSyfdnAjY/UxKVUjqy97R3bi4Ko+9YDfM
	WgBpJ4KkjEFh05TJh1i+Oq+dOaKqLlcXXejerYsP6O3nLMqu9oa3yVVqKUJ5yorMHmlpOshtUIx
	uEzosXsN1yYwdizLTII2skyKxcsLIpAWXOtLltebuzw/kJVcV+4o2gE3XtJcJTtD16fmUgAaWJS
	bRnDdt6wSZBfWc+jXK6N+21xs0k2tRFwTgHjU+eM8QdydURWapwt8VH1TgOnIlZu0CV76SrfhHZ
	UXAdw0qKA3RoqkcaRRv4Qun/128Vm6lYY3YWMJv7DxLBOJnkCjVKDKmSXaUoo9tAefe3t4m+stH
	z8SbJBUCU+b7q/zV2cUJ9q2f+qpVIcV7PkfuiWE8VErJ0VToH2Vq5JLgDnsWPmuwFwAtDaMzxht
	1/+9gd0cXGsCllpazXRZiIfiWDOiMwExNmRi0qEkCfnNW5u2XKl0XWvRLsduhRYNscE/qZU9nyc
	wQHrGwwjf+vfFzS8fVqjpMGq82npTXSjfmPt3apjjHDaqKpYp+r3/9eSFPLBQtfgGXMCoNdtZXf
	xEXybrl06bG/UsYBHhSc9M+j9YQzyRzRH2ZR8NrN53a21L93TDrP5PWHsqvzT/Y1vH5twks4+eY
	Ya+pBS4MygqYQqWh5HnRXJN4YVpFylZ+bwCTXvyBjZx9EWaPlpY1daw==
X-Received: by 2002:a05:7300:26a2:b0:386:b0ea:3263 with SMTP id 5a478bee46e88-386b0ea340cmr2766188eec.40.1795434239138;
        Mon, 23 Nov 2026 03:43:59 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:14e:94e0:654e:d7ff:13d2:447d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm41943583eec.10.2026.11.23.03.43.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:43:58 -0800 (PST)
From: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
To: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org
Cc: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	David Hildenbrand <david@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jmorris@namei.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>,
	Ketan Bhardwaj <ketan@armoriq.io>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [RFC PATCH v4 0/6] security: introduce Kernel Assurance Plane
Date: Mon, 23 Nov 2026 17:13:02 +0530
Message-ID: <20261123114308.8103-1-harisudhan@armoriq.io>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel Assurance Plane (KAP) adds an objective-scoped authority context as a
kernel object. An Intent Lineage Group (igroup) is that object: an externally
managed authority whose lifetime is tied to an objective rather than to a
process, a thread group or a sandbox, that a trusted controller can update or
revoke in place while unmodified worker tasks keep running.

v1 [1] was the design document. v2 added the implementation and moved the
control plane under securityfs. v3 [2] reworked the design document to answer
the v2 review. This version folds in the v3 review: automated review findings
and a request to put a diffstat on the cover letter. The design and the model
are unchanged from v3.

Changes since v3:

* Fixes from automated review (3/6, the LSM). Each was checked against the
  source; findings that did not reproduce were left alone.
  - Fix a use-after-free in the link check: the source parent dentry was read
    and then used across a sleeping allocation and d_path, where a concurrent
    rename could free it. Pin it with dget_parent and release it after.
  - Fix an uninitialised-stack infoleak on a short connect(): the target
    render read the address and port before addrlen was known to cover them.
    Require a family-sized addrlen and otherwise leave the address for the
    protocol layer to reject.
  - Close a fail-open path: when a mapping's backing path cannot be resolved,
    mmap and mprotect now run the execmem predicate with an unresolved target,
    so a revoked or expired igroup still denies rather than allowing the map.
  - Normalise /proc/self to the thread-group leader in the current PID
    namespace (task_tgid_vnr) rather than this thread's global PID.
  - Do not let an exact-path deny be slipped by unlinking the file first:
    d_path renders an unlinked file as "<path> (deleted)", so strip that
    suffix before matching.
  - Match a user-namespace create as "user:create" so a "user:*" allow or
    deny applies, rather than a bare "user" that only matched a wildcard.
  - Guard the transition-sequence parser against u64 overflow.
  - Reject a lineage root that carries control characters or the JSON string
    metacharacters, since it is written verbatim into the kap.events JSON.
* Control plane (4/6, securityfs).
  - kapfs now sets its superblock operations (simple_statfs), block size and
    time granularity.
  - Validate the lineage-root write the same way as above.
* Design document (1/6).
  - Clarify the epoch semantics, which were contradictory: a running task is
    narrowed by installing a new authority at the same epoch, which re-points
    the bound task without interrupting it; raising the epoch is what revokes
    a task, failing its checks closed until it is bound again.
* Cover letter: add the diffstat (thanks, Lorenzo).

The prototype runs as the guest kernel of Kata microVMs (Linux 6.18) and of
Docker Sandboxes (Linux 7.0). In a Kata guest under nested virtualization,
running the same binary unbound and then bound, enforcement adds 154 ns to a
read and 787 ns to an open, while the unhooked getpid control does not move. On
Docker Sandboxes, allow, deny and revoke were exercised on a real agent.

Known gaps, where feedback is welcome:

* Whether KAP should keep its own mediation or compose with Landlock and
  existing hooks is open and is question 1; the current series is the
  self-contained form.
* The authority wire form is a strict subset of JSON and is experimental.
* Decisions are serialized by one spinlock, and those that resolve a path
  allocate a PATH_MAX buffer before taking it. Both are prototype choices.
* igroups cannot be removed yet, and kap.procs keeps the pids written to it
  after those tasks exit. A task's binding lives in its task blob and is
  released with it.
* A thread created while its process is being bound can miss the binding.
  cgroups closes the same race with cgroup_threadgroup_rwsem; KAP does not yet.
* Control writes need CAP_SYS_ADMIN. CAP_MAC_ADMIN may be the better fit.
* unshare and setns call KAP directly because they have no LSM hook in this
  base (question 5 in the document).
* There are no selftests in this series yet. It was built with and without KAP
  and with networking, namespaces and io_uring disabled, and boot tested in
  QEMU with lock debugging (PROVE_LOCKING and DEBUG_ATOMIC_SLEEP): the control
  plane, file and exec decisions, epoch revocation of a running task and
  kap.default.
* The LSM ID is provisional and is for the LSM maintainers to confirm.

[1] https://lore.kernel.org/linux-security-module/20261021165748.19304-1-ketan@armoriq.io/
[2] https://lore.kernel.org/linux-security-module/20261110202246.274-1-harisudhan@armoriq.io/


HARIHARA SUDHAN. R (6):
  docs: security: Describe the Kernel Assurance Plane design
  security: kap: add the LSM ID and internal headers
  security: add the Kernel Assurance Plane LSM
  security: kap: add the securityfs control plane
  kernel: add KAP checks for unshare and setns
  MAINTAINERS: add an entry for the Kernel Assurance Plane

 Documentation/ABI/testing/securityfs-kap | 111 +++
 Documentation/security/index.rst         |   1 +
 Documentation/security/kap.rst           | 341 ++++++++
 MAINTAINERS                              |  10 +
 include/linux/kap.h                      |  16 +
 include/linux/lsm_count.h                |   9 +-
 include/uapi/linux/lsm.h                 |   1 +
 kernel/fork.c                            |   4 +
 kernel/nsproxy.c                         |   5 +
 security/Kconfig                         |   1 +
 security/Makefile                        |   1 +
 security/kap/Kconfig                     |  14 +
 security/kap/Makefile                    |   2 +
 security/kap/igroup.c                    | 976 +++++++++++++++++++++++
 security/kap/kap.h                       | 160 ++++
 security/kap/kap_lsm.c                   | 903 +++++++++++++++++++++
 security/kap/kapfs.c                     | 530 ++++++++++++
 17 files changed, 3084 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/securityfs-kap
 create mode 100644 Documentation/security/kap.rst
 create mode 100644 include/linux/kap.h
 create mode 100644 security/kap/Kconfig
 create mode 100644 security/kap/Makefile
 create mode 100644 security/kap/igroup.c
 create mode 100644 security/kap/kap.h
 create mode 100644 security/kap/kap_lsm.c
 create mode 100644 security/kap/kapfs.c


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0

