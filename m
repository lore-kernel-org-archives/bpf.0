Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53801BE
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:30:58 -0800 (PST)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 4C2DD2B68D769; Tue, 12 Dec 2023 14:30:45 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 1/5] bpf: Refactor to have a memalloc cache destroying function
Date: Tue, 12 Dec 2023 14:30:45 -0800
Message-Id: <20231212223045.2137288-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212223040.2135547-1-yonghong.song@linux.dev>
References: <20231212223040.2135547-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function, named as bpf_mem_alloc_destroy_cache(), will be used
in the subsequent patch.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/memalloc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 6a51cfe4c2d6..75068167e745 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -618,6 +618,13 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	free_all(llist_del_all(&c->waiting_for_gp), percpu);
 }
=20
+static void bpf_mem_alloc_destroy_cache(struct bpf_mem_cache *c)
+{
+	WRITE_ONCE(c->draining, true);
+	irq_work_sync(&c->refill_work);
+	drain_mem_cache(c);
+}
+
 static void check_mem_cache(struct bpf_mem_cache *c)
 {
 	WARN_ON_ONCE(!llist_empty(&c->free_by_rcu_ttrace));
@@ -723,9 +730,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 		rcu_in_progress =3D 0;
 		for_each_possible_cpu(cpu) {
 			c =3D per_cpu_ptr(ma->cache, cpu);
-			WRITE_ONCE(c->draining, true);
-			irq_work_sync(&c->refill_work);
-			drain_mem_cache(c);
+			bpf_mem_alloc_destroy_cache(c);
 			rcu_in_progress +=3D atomic_read(&c->call_rcu_ttrace_in_progress);
 			rcu_in_progress +=3D atomic_read(&c->call_rcu_in_progress);
 		}
@@ -740,9 +745,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			cc =3D per_cpu_ptr(ma->caches, cpu);
 			for (i =3D 0; i < NUM_CACHES; i++) {
 				c =3D &cc->cache[i];
-				WRITE_ONCE(c->draining, true);
-				irq_work_sync(&c->refill_work);
-				drain_mem_cache(c);
+				bpf_mem_alloc_destroy_cache(c);
 				rcu_in_progress +=3D atomic_read(&c->call_rcu_ttrace_in_progress);
 				rcu_in_progress +=3D atomic_read(&c->call_rcu_in_progress);
 			}
--=20
2.34.1

